/// Push bildirim gönderme yapılandırması.
///
/// [endpoint] push gönderen Cloudflare Worker adresidir (bkz.
/// `cloudflare/fcm-worker.js`). Alıcı taraf (izin/token/abonelik) Worker'sız
/// çalışır; yalnızca **gönderme** (duyuru/aidat push'u) bu adresi gerektirir.
///
/// Varsayılan olarak yayındaki Worker'a bağlanır; bu adres **gizli değildir**
/// (servis hesabı Worker'ın secret'ında durur, Worker ayrıca çağıranın Firebase
/// kimliğini doğrulayıp admin/antrenör rolünü kontrol eder — adresi bilmek tek
/// başına yetki vermez). Böylece push, [AiConfig] gibi **her derlemede bayraksız
/// çalışır**. Farklı bir Worker'a yönlendirmek için derlemede geçersiz kılınabilir:
///   flutter run --dart-define=FCM_ENDPOINT=https://sporokulu-fcm.xxx.workers.dev
/// Boş verilirse (ör. bilinçli devre dışı bırakma) gönderme sessizce atlanır;
/// alıcı taraf (izin/jeton/abonelik) ve uygulamanın geri kalanı etkilenmez.
class FcmConfig {
  FcmConfig._();

  static const String endpoint = String.fromEnvironment(
    'FCM_ENDPOINT',
    defaultValue: 'https://sporokulu-fcm.sportek.workers.dev',
  );

  /// Herkese açık duyuruların gönderildiği FCM konusu (alıcı taraf bu konuya
  /// abone olur; bkz. NotificationService).
  static const String broadcastTopic = 'all';

  static bool get isConfigured => endpoint.isNotEmpty;
}
