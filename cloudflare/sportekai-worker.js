// SporTekAi — Groq icin Cloudflare Worker proxy (OpenAI uyumlu).
//
// Amac: Groq API anahtarini uygulamaya gommeden gizli tutmak. Uygulama bu
// Worker'i cagirir; Worker, anahtari Authorization basligina ekleyip istegi
// Groq'a iletir ve yaniti oldugu gibi doner. Tamamen ucretsiz katmanda calisir.
//
// Kurulum (kisa):
//   1) console.groq.com -> ucretsiz API anahtari al
//   2) npm i -g wrangler && wrangler login
//   3) wrangler secret put GROQ_API_KEY   (anahtari yapistir)
//   4) wrangler deploy
//   5) Cikan https://sportekai.<hesap>.workers.dev adresini uygulamaya ver:
//      flutter run --dart-define=SPORTEKAI_ENDPOINT=https://sportekai.<hesap>.workers.dev
//
// Istek govdesi : { "messages": [...], "model"?: "...", "temperature"?: 0.4 }
// Yanit         : Groq'un OpenAI uyumlu JSON'u -> choices[0].message.content

const GROQ_URL = 'https://api.groq.com/openai/v1/chat/completions';
const DEFAULT_MODEL = 'llama-3.3-70b-versatile';

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

function jsonResponse(obj, status = 200) {
  return new Response(JSON.stringify(obj), {
    status,
    headers: { 'Content-Type': 'application/json' },
  });
}

function withCors(response) {
  response.headers.set('Access-Control-Allow-Origin', '*');
  response.headers.set('Access-Control-Allow-Methods', 'POST, OPTIONS');
  response.headers.set('Access-Control-Allow-Headers', 'Content-Type');
  return response;
}
