import 'package:package_info_plus/package_info_plus.dart';

/// Uygulama geneli sabit bilgiler (sürüm ve destek kanalları).
///
/// [version] artık pubspec.yaml ile ELLE senkron tutulmaz; uygulama açılışında
/// [load] ile paket bilgisinden okunur (tek kaynak: pubspec `version`). Böylece
/// sürüm numarası her zaman gerçek paketle tutarlıdır.
///
/// Destek bilgileri örnek/yer tutucu değerlerdir; yayından önce GERÇEK, izlenen
/// kanallarla güncellenmelidir (uygulamada ve docs/hesap-silme.html'de görünür).
class AppInfo {
  AppInfo._();

  /// Uygulama sürümü (ör. "1.0.0"). [load] çağrılana kadar boştur; UI boşsa
  /// sürümü göstermez.
  static String version = '';

  static const String supportPhone = '(543) 484 78 30';
  static const String supportEmail = 'mefepalta@gmail.com';

  /// Sürümü paketten (pubspec.yaml `version`, `+build` hariç) yükler. Uygulama
  /// açılışında bir kez çağrılır; hata olursa [version] boş kalır (sessiz).
  static Future<void> load() async {
    try {
      final info = await PackageInfo.fromPlatform();
      version = info.version;
    } catch (_) {
      // Paket bilgisi okunamadı; sürüm boş kalır (kritik değil).
    }
  }
}
