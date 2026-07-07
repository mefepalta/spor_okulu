import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Uygulamanın aydınlık/karanlık mod tercihini tutan ve cihazda saklayan
/// basit kontrolcü.
///
/// [mode] bir [ValueNotifier] olduğundan, [MaterialApp] bir
/// [ValueListenableBuilder] ile buna bağlanır ve tercih değişince tema anında
/// güncellenir. Tercih [SharedPreferences] ile kalıcıdır.
class ThemeController {
  ThemeController._();

  static final ThemeController instance = ThemeController._();

  static const String _prefKey = 'themeMode';

  final ValueNotifier<ThemeMode> mode = ValueNotifier<ThemeMode>(
    ThemeMode.system,
  );

  /// Kayıtlı tercihi yükler; yoksa cihaz ayarını (system) kullanır.
  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      mode.value = _fromName(prefs.getString(_prefKey));
    } catch (_) {
      // Tercih okunamazsa varsayılan (system) ile devam et.
    }
  }

  /// Tercihi ayarlar ve kalıcı olarak kaydeder.
  Future<void> setMode(ThemeMode value) async {
    mode.value = value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, value.name);
    } catch (_) {
      // Kaydedilemezse en azından bu oturumda uygulanmış olur.
    }
  }

  /// O anda görünen parlaklığa göre aydınlık↔karanlık arasında geçiş yapar.
  void toggle(Brightness current) {
    setMode(current == Brightness.dark ? ThemeMode.light : ThemeMode.dark);
  }

  ThemeMode _fromName(String? name) {
    switch (name) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
