/// Push bildirim gönderme yapılandırması.
///
/// [endpoint] push gönderen Cloudflare Worker adresidir (bkz.
/// `cloudflare/fcm-worker.js`). Alıcı taraf (izin/token/abonelik) Worker'sız
/// çalışır; yalnızca **gönderme** (duyuru/aidat push'u) bu adresi gerektirir.
///
/// Varsayılan boştur: Worker deploy edilip adres verilene kadar gönderme sessizce
/// devre dışıdır (uygulamanın geri kalanı etkilenmez). Adresi derlemede ver:
///   flutter run --dart-define=FCM_ENDPOINT=https://sporokulu-fcm.xxx.workers.dev
class FcmConfig {
  FcmConfig._();

  static const String endpoint = String.fromEnvironment(
    'FCM_ENDPOINT',
    defaultValue: '',
  );

  /// Herkese açık duyuruların gönderildiği FCM konusu (alıcı taraf bu konuya
  /// abone olur; bkz. NotificationService).
  static const String broadcastTopic = 'all';

  static bool get isConfigured => endpoint.isNotEmpty;
}
