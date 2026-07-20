// SporTekAi — Groq icin Cloudflare Worker proxy (OpenAI uyumlu).
//
// Amac: Groq API anahtarini uygulamaya gommeden gizli tutmak. Uygulama bu
// Worker'i cagirir; Worker, anahtari Authorization basligina ekleyip istegi
// Groq'a iletir ve yaniti oldugu gibi doner. Tamamen ucretsiz katmanda calisir.
//
// GUVENLIK (K-2): Istekler artik Firebase kimlik dogrulamasi ister. Cagiran,
//   Authorization: Bearer <Firebase ID token>
// gondermeli; Worker bu token'i RS256 ile dogrular (Google acik anahtarlari,
// aud = projectId). Boylece adresi ele geciren biri, gecerli bir Firebase
// oturumu olmadan Groq anahtarini kullanamaz. (Onceden kimlik dogrulamasi yoktu
// ve adres herkese aciksti — bu bulgu giderildi.)
//
// Kurulum (kisa):
//   1) console.groq.com -> ucretsiz API anahtari al
//   2) npm i -g wrangler && wrangler login
//   3) cloudflare/ klasorunden:  wrangler secret put GROQ_API_KEY
//   4) cloudflare/ klasorunden:  wrangler deploy   (cloudflare/wrangler.toml -> name=sportekai)
//   5) (istege bagli) Farkli proje icin: wrangler secret put FIREBASE_PROJECT_ID
//
// Istek govdesi : { "messages": [...], "model"?: "...", "temperature"?: 0.4 }
// Yanit         : Groq'un OpenAI uyumlu JSON'u -> choices[0].message.content

const GROQ_URL = 'https://api.groq.com/openai/v1/chat/completions';
const DEFAULT_MODEL = 'llama-3.3-70b-versatile';
const DEFAULT_PROJECT_ID = 'mefe-spor-okulu-2026';

// Isolate omru boyunca Google acik anahtar onbellegi (soguk baslangicta dolar).
let _jwkCache = null; // { keys: {kid: CryptoKey}, expiresAt }

export default {
  async fetch(request, env) {
    if (request.method === 'OPTIONS') {
      return withCors(new Response(null, { status: 204 }));
    }
    if (request.method !== 'POST') {
      return withCors(jsonResponse({ error: 'Yalnizca POST desteklenir.' }, 405));
    }
    if (!env.GROQ_API_KEY) {
      return withCors(
        jsonResponse({ error: 'Sunucuda GROQ_API_KEY tanimli degil.' }, 500),
      );
    }

    // --- Kimlik dogrulama (K-2): gecerli Firebase ID token zorunlu ---
    const projectId = env.FIREBASE_PROJECT_ID || DEFAULT_PROJECT_ID;
    const authHeader = request.headers.get('Authorization') || '';
    const idToken = authHeader.startsWith('Bearer ') ? authHeader.slice(7) : '';
    if (!idToken) {
      return withCors(jsonResponse({ error: 'Kimlik dogrulama gerekli.' }, 401));
    }
    try {
      await verifyIdToken(idToken, projectId);
    } catch (error) {
      return withCors(
        jsonResponse({ error: `Gecersiz kimlik: ${error.message}` }, 401),
      );
    }

    let body;
    try {
      body = await request.json();
    } catch {
      return withCors(jsonResponse({ error: 'Gecersiz JSON govdesi.' }, 400));
    }

    if (!Array.isArray(body.messages) || body.messages.length === 0) {
      return withCors(
        jsonResponse({ error: '"messages" alani zorunludur.' }, 400),
      );
    }

    const payload = {
      model: typeof body.model === 'string' ? body.model : DEFAULT_MODEL,
      messages: body.messages,
      temperature:
        typeof body.temperature === 'number' ? body.temperature : 0.4,
      max_tokens: typeof body.max_tokens === 'number' ? body.max_tokens : 800,
    };

    let groqResponse;
    try {
      groqResponse = await fetch(GROQ_URL, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${env.GROQ_API_KEY}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
      });
    } catch (error) {
      return withCors(
        jsonResponse({ error: 'Groq servisine ulasilamadi.' }, 502),
      );
    }

    // Groq'un yanitini (basari ya da hata) oldugu gibi ilet.
    const text = await groqResponse.text();
    return withCors(
      new Response(text, {
        status: groqResponse.status,
        headers: { 'Content-Type': 'application/json' },
      }),
    );
  },
};

// ---------------------------------------------------------------------------
// Firebase ID token dogrulama (RS256, Google acik anahtarlariyla).
// (fcm-worker.js ile ayni desen; burada rol okunmaz — gecerli oturum yeter.)
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
  let maxAge = 3600;
  const cc = response.headers.get('Cache-Control') || '';
  const match = cc.match(/max-age=(\d+)/);
  if (match) maxAge = parseInt(match[1], 10);
  _jwkCache = { keys, expiresAt: now + maxAge * 1000 };
  return keys;
}

// ---------------------------------------------------------------------------
// Kucuk yardimcilar
// ---------------------------------------------------------------------------

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

function bytesToStr(bytes) {
  return new TextDecoder().decode(bytes);
}

function jsonResponse(obj, status = 200) {
  return new Response(JSON.stringify(obj), {
    status,
    headers: { 'Content-Type': 'application/json' },
  });
}

// Not: CORS joker (*) birak; token dogrulamasi asil kapidir. Tarayicidan gelen
// yetkisiz istek gecerli bir Firebase token tasimadigi icin 401 alir. Mobil
// istemci (Flutter http) CORS uygulamaz; bu baslik yalnizca tarayicilari ilgilendirir.
function withCors(response) {
  response.headers.set('Access-Control-Allow-Origin', '*');
  response.headers.set('Access-Control-Allow-Methods', 'POST, OPTIONS');
  response.headers.set(
    'Access-Control-Allow-Headers',
    'Content-Type, Authorization',
  );
  return response;
}
