/// SporTekAi yapılandırması.
///
/// [endpoint] Cloudflare Worker proxy adresidir. Varsayılan olarak yayındaki
/// Worker'a bağlanır; bu adres gizli değildir (Groq anahtarı Worker'ın içinde
/// saklanır, adres herkese açık bir proxy'dir). Farklı bir Worker'a yönlendirmek
/// için derleme sırasında geçersiz kılınabilir:
///   flutter run --dart-define=SPORTEKAI_ENDPOINT=https://sportekai.xxx.workers.dev
/// Boşsa (ör. bilinçli olarak devre dışı bırakılırsa) AI ekranı
/// "yapılandırılmadı" durumunu gösterir; uygulamanın geri kalanı etkilenmez.
class AiConfig {
  AiConfig._();

  static const String endpoint = String.fromEnvironment(
    'SPORTEKAI_ENDPOINT',
    defaultValue: 'https://sportekai.sportek.workers.dev',
  );

  /// Groq üzerindeki açık kaynak model (Worker varsayılanıyla uyumlu).
  static const String model = 'llama-3.3-70b-versatile';

  static bool get isConfigured => endpoint.isNotEmpty;
}
