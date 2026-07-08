import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dil seçicide gösterilen bir seçenek: [locale] null ise "Sistem" (cihaz dili).
class AppLocaleOption {
  final Locale? locale;

  /// Dilin kendi dilindeki adı (ör. "Español"). "Sistem" seçeneği için
  /// arayüzde [AppLocalizations] üzerinden çevrilir; buradaki değer yedektir.
  final String label;

  const AppLocaleOption(this.locale, this.label);
}

/// Uygulamanın dil tercihini tutan ve cihazda saklayan kontrolcü.
///
/// [ThemeController] ile aynı deseni izler: [locale] bir [ValueNotifier]
/// olduğundan [MaterialApp] buna bağlanır ve tercih değişince uygulama anında
/// yeniden çevrilir. `null` değer "cihaz dilini izle" demektir. Tercih
/// [SharedPreferences] ile kalıcıdır.
class LocaleController {
  LocaleController._();

  static final LocaleController instance = LocaleController._();

  static const String _prefKey = 'localeCode';

  /// Uygulamanın desteklediği diller. (Arapça sonraki aşamada eklenecek.)
  static const List<Locale> supportedLocales = [
    Locale('tr'),
    Locale('en'),
    Locale('es'),
    Locale('ru'),
    Locale('fr'),
  ];

  /// Dil seçicide listelenecek seçenekler (Sistem + her dil).
  static const List<AppLocaleOption> options = [
    AppLocaleOption(null, 'Sistem'),
    AppLocaleOption(Locale('tr'), 'Türkçe'),
    AppLocaleOption(Locale('en'), 'English'),
    AppLocaleOption(Locale('es'), 'Español'),
    AppLocaleOption(Locale('ru'), 'Русский'),
    AppLocaleOption(Locale('fr'), 'Français'),
  ];

  /// Seçili dil; `null` ise cihaz dili izlenir.
  final ValueNotifier<Locale?> locale = ValueNotifier<Locale?>(null);

  /// Kayıtlı tercihi yükler; yoksa "Sistem" (cihaz dili) ile başlar.
  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_prefKey);
      locale.value = (code == null || code == 'system') ? null : Locale(code);
    } catch (_) {
      // Tercih okunamazsa varsayılan (sistem) ile devam et.
    }
  }

  /// Tercihi ayarlar ve kalıcı olarak kaydeder. [value] null ise cihaz dili.
  Future<void> setLocale(Locale? value) async {
    locale.value = value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, value?.languageCode ?? 'system');
    } catch (_) {
      // Kaydedilemezse en azından bu oturumda uygulanmış olur.
    }
  }
}
