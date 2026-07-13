// SporOkulu FCM — push bildirim gonderen Cloudflare Worker (HTTP v1).
//
// Amac: Firebase servis hesabini uygulamaya gommeden gizli tutup, YALNIZCA
// yetkili (admin/antrenor) kullanicinin push gondermesine izin vermek.
//
// Akis:
//   App (admin) --Authorization: Bearer <Firebase ID token>--> Worker
//   Worker: (1) ID token'i dogrular (Google acik anahtarlariyla, RS256)
//           (2) Firestore'dan cagiranin rolunu okur (admin/coach mi?)
//           (3) servis hesabiyla OAuth access token alir
//           (4) FCM HTTP v1 ile konuya ('all') ya da tek cihaza (token) gonderir
//
// Kurulum (kisa):
//   1) Firebase Console -> Proje ayarlari -> Servis hesaplari ->
//      "Yeni ozel anahtar olustur" -> inen JSON dosyasini kopyala.
//   2) wrangler secret put FCM_SERVICE_ACCOUNT --name sporokulu-fcm
//      (JSON'un tamamini tek satir/yapistir olarak ver)
//   3) wrangler deploy cloudflare/fcm-worker.js --name sporokulu-fcm \
//        --compatibility-date 2024-11-01
//   4) Cikan https://sporokulu-fcm.<hesap>.workers.dev adresini uygulamaya ver:
//      flutter run --dart-define=FCM_ENDPOINT=https://sporokulu-fcm.<hesap>.workers.dev
//
// Istek govdesi (JSON):
//   { "mode": "topic", "topic": "all", "title": "...", "body": "...", "data"?: {...} }
//   { "mode": "token", "token": "<cihaz FCM jetonu>", "title": "...", "body": "..." }

const TOKEN_SCOPES =
  'https://www.googleapis.com/auth/firebase.messaging ' +
  'https://www.googleapis.com/auth/datastore';

// Isolate omru boyunca kucuk onbellekler (soguk baslangicta yeniden dolar).
let _accessTokenCache = null; // { token, expiresAt }
let _jwkCache = null; // { keys: {kid: CryptoKey}, expiresAt }

export default {
  async fetch(request, env) {
    if (request.method === 'OPTIONS') {
      return withCors(new Response(null, { status: 204 }));
    }
    if (request.method !== 'POST') {
      return withCors(json({ error: 'Yalnizca POST desteklenir.' }, 405));
    }
    if (!env.FCM_SERVICE_ACCOUNT) {
      return withCors(
        json({ error: 'Sunucuda FCM_SERVICE_ACCOUNT tanimli degil.' }, 500),
      );
    }

    let sa;
    try {
      sa = JSON.parse(env.FCM_SERVICE_ACCOUNT);
    } catch {
      return withCors(json({ error: 'Servis hesabi JSON gecersiz.' }, 500));
    }
    const projectId = sa.project_id;

    // 1) Cagiranin Firebase ID token'ini dogrula.
    const authHeader = request.headers.get('Authorization') || '';
    const idToken = authHeader.startsWith('Bearer ')
      ? authHeader.slice(7)
      : '';
    if (!idToken) {
      return withCors(json({ error: 'Kimlik dogrulama gerekli.' }, 401));
    }

    let claims;
    try {
      claims = await verifyIdToken(idToken, projectId);
    } catch (error) {
      return withCors(json({ error: `Gecersiz kimlik: ${error.message}` }, 401));
    }
    const uid = claims.sub;

    // 2) Servis hesabiyla access token al (FCM + Firestore icin).
    let accessToken;
    try {
      accessToken = await getAccessToken(sa);
    } catch (error) {
      return withCors(
        json({ error: `Yetki alinamadi: ${error.message}` }, 502),
      );
    }

    // 3) Cagiranin rolunu Firestore'dan oku; yalnizca admin/antrenor gonderebilir.
    let role;
    try {
      role = await getUserRole(projectId, accessToken, uid);
    } catch (error) {
      return withCors(json({ error: `Rol okunamadi: ${error.message}` }, 502));
    }
    if (role !== 'admin' && role !== 'coach') {
      return withCors(
        json({ error: 'Bu islem icin yetkiniz yok (admin/antrenor).' }, 403),
      );
    }

    // 4) Istek govdesini dogrula ve FCM mesaji kur.
    let body;
    try {
      body = await request.json();
    } catch {
      return withCors(json({ error: 'Gecersiz JSON govdesi.' }, 400));
    }

    const title = typeof body.title === 'string' ? body.title.trim() : '';
    const text = typeof body.body === 'string' ? body.body.trim() : '';
    if (!title && !text) {
      return withCors(json({ error: 'title veya body zorunludur.' }, 400));
    }

    // Not: android.notification.channel_id BILEREK verilmiyor. Ozel bir bildirim
    // kanali olusturmadigimiz icin (lean; flutter_local_notifications yok),
    // var olmayan bir kanal kimligi verilirse Android 8+ bildirimi SESSIZCE
    // dusurur. Kanal belirtilmeyince firebase_messaging kendi varsayilan
    // (fallback) kanalini olusturup gosterir.
    const message = {
      notification: { title: title || 'Spor Okulu', body: text },
      android: { priority: 'high' },
    };
    if (body.data && typeof body.data === 'object') {
      // FCM data alani yalnizca string degerler kabul eder.
      const data = {};
      for (const [k, v] of Object.entries(body.data)) data[k] = String(v);
      message.data = data;
    }

    if (body.mode === 'topic') {
      const topic = typeof body.topic === 'string' ? body.topic : '';
      if (!/^[A-Za-z0-9-_.~%]+$/.test(topic)) {
        return withCors(json({ error: 'Gecersiz topic.' }, 400));
      }
      message.topic = topic;
    } else if (body.mode === 'token') {
      const token = typeof body.token === 'string' ? body.token : '';
      if (!token) {
        return withCors(json({ error: 'token zorunludur.' }, 400));
      }
      message.token = token;
    } else {
      return withCors(json({ error: 'mode "topic" ya da "token" olmali.' }, 400));
    }

    // 5) FCM HTTP v1'e gonder.
    let fcmResponse;
    try {
      fcmResponse = await fetch(
        `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`,
        {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${accessToken}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ message }),
        },
      );
    } catch (error) {
      return withCors(json({ error: 'FCM servisine ulasilamadi.' }, 502));
    }

    const fcmText = await fcmResponse.text();
    return withCors(
      new Response(fcmText, {
        status: fcmResponse.status,
        headers: { 'Content-Type': 'application/json' },
      }),
    );
  },
};

// ---------------------------------------------------------------------------
// Firebase ID token dogrulama (RS256, Google acik anahtarlariyla)
// ---------------------------------------------------------------------------

async function verifyIdToken(idToken, projectId) {
  const parts = idToken.split('.');
  if (parts.length !== 3) throw new Error('bicim');
  const header = JSON.parse(bytesToStr(b64urlToBytes(parts[0])));
  const payload = JSON.parse(bytesToStr(b64urlToBytes(parts[1])));
  const now = Math.floor(Date.now() / 1000);

  if (header.alg !== 'RS256') throw new Error('alg');
  if (payload.aud !== projectId) throw new Error('aud');
  if (payload.iss !== `https://securetoken.google.com/${projectId}`) {
    throw new Error('iss');
  }
  if (!payload.sub) throw new Error('sub');
  if (typeof payload.exp !== 'number' || payload.exp < now) {
    throw new Error('suresi dolmus');
  }

  const keys = await getSecureTokenKeys();
  const key = keys[header.kid];
  if (!key) throw new Error('kid');

  const signed = new TextEncoder().encode(`${parts[0]}.${parts[1]}`);
  const signature = b64urlToBytes(parts[2]);
  const valid = await crypto.subtle.verify(
    'RSASSA-PKCS1-v1_5',
    key,
    signature,
    signed,
  );
  if (!valid) throw new Error('imza');
  return payload;
}

async function getSecureTokenKeys() {
  const now = Date.now();
  if (_jwkCache && _jwkCache.expiresAt > now) return _jwkCache.keys;

  const response = await fetch(
    'https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com',
  );
  const jwkSet = await response.json();
  const keys = {};
  for (const jwk of jwkSet.keys) {
    keys[jwk.kid] = await crypto.subtle.importKey(
      'jwk',
      jwk,
      { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
      false,
      ['verify'],
    );
  }
  // Cache-Control max-age varsa ona uy; yoksa 1 saat.
  let maxAge = 3600;
  const cc = response.headers.get('Cache-Control') || '';
  const match = cc.match(/max-age=(\d+)/);
  if (match) maxAge = parseInt(match[1], 10);
  _jwkCache = { keys, expiresAt: now + maxAge * 1000 };
  return keys;
}

// ---------------------------------------------------------------------------
// Servis hesabi -> OAuth access token (JWT bearer akisi)
// ---------------------------------------------------------------------------

async function getAccessToken(sa) {
  const now = Date.now();
  if (_accessTokenCache && _accessTokenCache.expiresAt > now + 60000) {
    return _accessTokenCache.token;
  }

  const iat = Math.floor(now / 1000);
  const exp = iat + 3600;
  const header = { alg: 'RS256', typ: 'JWT' };
  const claim = {
    iss: sa.client_email,
    scope: TOKEN_SCOPES,
    aud: sa.token_uri || 'https://oauth2.googleapis.com/token',
    iat,
    exp,
  };

  const encHeader = b64urlFromStr(JSON.stringify(header));
  const encClaim = b64urlFromStr(JSON.stringify(claim));
  const signingInput = `${encHeader}.${encClaim}`;

  const key = await crypto.subtle.importKey(
    'pkcs8',
    pemToBytes(sa.private_key),
    { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  const signature = await crypto.subtle.sign(
    'RSASSA-PKCS1-v1_5',
    key,
    new TextEncoder().encode(signingInput),
  );
  const jwt = `${signingInput}.${b64urlFromBytes(new Uint8Array(signature))}`;

  const response = await fetch(
    sa.token_uri || 'https://oauth2.googleapis.com/token',
    {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body:
        'grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=' +
        encodeURIComponent(jwt),
    },
  );
  const data = await response.json();
  if (!data.access_token) {
    throw new Error(data.error_description || data.error || 'token yok');
  }
  _accessTokenCache = {
    token: data.access_token,
    expiresAt: now + (data.expires_in || 3600) * 1000,
  };
  return data.access_token;
}

// ---------------------------------------------------------------------------
// Firestore REST -> kullanicinin rolu
// ---------------------------------------------------------------------------

async function getUserRole(projectId, accessToken, uid) {
  const response = await fetch(
    `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents/users/${uid}`,
    { headers: { Authorization: `Bearer ${accessToken}` } },
  );
  if (!response.ok) throw new Error(`durum ${response.status}`);
  const doc = await response.json();
  return doc.fields && doc.fields.role ? doc.fields.role.stringValue : '';
}

// ---------------------------------------------------------------------------
// Kucuk yardimcilar
// ---------------------------------------------------------------------------

function pemToBytes(pem) {
  const b64 = pem
    .replace(/-----BEGIN PRIVATE KEY-----/, '')
    .replace(/-----END PRIVATE KEY-----/, '')
    .replace(/\s+/g, '');
  return b64ToBytes(b64).buffer;
}

function b64ToBytes(b64) {
  const bin = atob(b64);
  const bytes = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i);
  return bytes;
}

function b64urlToBytes(s) {
  let b64 = s.replace(/-/g, '+').replace(/_/g, '/');
  while (b64.length % 4) b64 += '=';
  return b64ToBytes(b64);
}

function b64urlFromBytes(bytes) {
  let bin = '';
  for (const b of bytes) bin += String.fromCharCode(b);
  return btoa(bin).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
}

function b64urlFromStr(str) {
  return b64urlFromBytes(new TextEncoder().encode(str));
}

function bytesToStr(bytes) {
  return new TextDecoder().decode(bytes);
}

function json(obj, status = 200) {
  return new Response(JSON.stringify(obj), {
    status,
    headers: { 'Content-Type': 'application/json' },
  });
}

function withCors(response) {
  response.headers.set('Access-Control-Allow-Origin', '*');
  response.headers.set('Access-Control-Allow-Methods', 'POST, OPTIONS');
  response.headers.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  return response;
}
