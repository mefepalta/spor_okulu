# SporTekAi — Cloudflare Worker (Groq proxy)

Bu Worker, Groq API anahtarını uygulamaya gömmeden gizli tutar. Uygulama
Worker'a istek atar; Worker anahtarı ekleyip Groq'a iletir ve yanıtı döner.
Hem Cloudflare hem Groq ücretsiz katmanda çalışır.

## Kurulum

1. **Groq anahtarı al** — <https://console.groq.com> → *API Keys* → ücretsiz anahtar oluştur.

2. **Wrangler'ı kur ve giriş yap**
   ```bash
   npm install -g wrangler
   wrangler login
   ```

3. **Anahtarı gizli olarak ekle** (bu klasörün içinden)
   ```bash
   wrangler secret put GROQ_API_KEY
   # açılan isteme Groq anahtarını yapıştır
   ```

4. **Yayınla**
   ```bash
   wrangler deploy
   ```
   Çıktıdaki adresi not al: `https://sportekai.<hesabın>.workers.dev`

5. **Uygulamaya bağla** — bu adresi derleme sırasında ver:
   ```bash
   flutter run --dart-define=SPORTEKAI_ENDPOINT=https://sportekai.<hesabın>.workers.dev
   ```
   (Yayın derlemesi için `flutter build apk --dart-define=SPORTEKAI_ENDPOINT=...`)

Adres verilmezse uygulama SporTekAi ekranında "henüz yapılandırılmadı" uyarısı
gösterir; diğer özellikler normal çalışmaya devam eder.

## Sözleşme

- **İstek** (POST, JSON): `{ "messages": [...], "model"?: "...", "temperature"?: 0.4 }`
- **Yanıt**: Groq'un OpenAI uyumlu JSON'u → `choices[0].message.content`

Modeli değiştirmek için `sportekai-worker.js` içindeki `DEFAULT_MODEL` sabitini
veya uygulamadaki `AiConfig.model` değerini güncelle.

## Notlar

- Uygulama modele **yalnızca anonim/özet veri** gönderir (ham kişisel veri değil).
- İstersen kötüye kullanımı kısmak için Worker'a basit bir uygulama-jetonu
  kontrolü (paylaşılan gizli başlık) veya Cloudflare rate-limit kuralı eklenebilir.
