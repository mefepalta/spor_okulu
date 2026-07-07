/// SporTekAi yapılandırması.
///
/// [endpoint] Cloudflare Worker proxy adresidir ve derleme sırasında verilir:
///   flutter run --dart-define=SPORTEKAI_ENDPOINT=https://sportekai.xxx.workers.dev
/// Boşsa AI ekranı "yapılandırılmadı" durumunu gösterir; uygulamanın geri kalanı
/// etkilenmez.
class AiConfig {
  AiConfig._();

  static const String endpoint = String.fromEnvironment('SPORTEKAI_ENDPOINT');

  /// Groq üzerindeki açık kaynak model (Worker varsayılanıyla uyumlu).
  static const String model = 'llama-3.3-70b-versatile';

  static bool get isConfigured => endpoint.isNotEmpty;
}
