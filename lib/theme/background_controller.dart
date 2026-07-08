import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dekoratif arka planın (dalga + partikül) yoğunluk seviyesi.
enum BackgroundLevel {
  /// Yüksek: dalga efekti + hareketli partiküller.
  full,

  /// Orta: yalnızca dalga efekti (partikül yok).
  waves,

  /// Düşük: arka planda dekor yok, yalnızca düz zemin.
  none,
}

/// Arka plan efekti seviyesini tutan ve cihazda saklayan basit kontrolcü.
///
/// [ThemeController] ile aynı deseni izler: [level] bir [ValueNotifier]
/// olduğundan, [WaveBackground] buna bağlanır ve tercih değişince arka plan
/// anında güncellenir. Tercih [SharedPreferences] ile kalıcıdır.
class BackgroundController {
  BackgroundController._();

  static final BackgroundController instance = BackgroundController._();

  static const String _prefKey = 'backgroundLevel';

  final ValueNotifier<BackgroundLevel> level = ValueNotifier<BackgroundLevel>(
    BackgroundLevel.full,
  );

  /// Kayıtlı tercihi yükler; yoksa en zengin seviye (full) ile başlar.
  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      level.value = _fromName(prefs.getString(_prefKey));
    } catch (_) {
      // Tercih okunamazsa varsayılan (full) ile devam et.
    }
  }

  /// Tercihi ayarlar ve kalıcı olarak kaydeder.
  Future<void> setLevel(BackgroundLevel value) async {
    level.value = value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, value.name);
    } catch (_) {
      // Kaydedilemezse en azından bu oturumda uygulanmış olur.
    }
  }

  BackgroundLevel _fromName(String? name) {
    switch (name) {
      case 'waves':
        return BackgroundLevel.waves;
      case 'none':
        return BackgroundLevel.none;
      default:
        return BackgroundLevel.full;
    }
  }
}
