import 'package:flutter/material.dart';

/// Uygulamanın merkezi renk paleti.
///
/// Tüm ekranlar bu tonları kullanır; böylece marka rengini tek yerden
/// değiştirebiliriz. Ana kimlik, açılış görselindeki derin mavidir.
class AppColors {
  AppColors._();

  /// Açılış ekranıyla aynı derin marka mavisi.
  static const Color deep = Color(0xFF053791);

  /// Ana vurgu mavisi (buton, appbar, ikon).
  static const Color primary = Color(0xFF1565C0);

  /// Orta ton mavi — dalga ve kart aksanlarında.
  static const Color mid = Color(0xFF2979FF);

  /// Açık gök mavisi — dalganın parlak şeritleri.
  static const Color sky = Color(0xFF42A5F5);

  /// En açık ışıltı tonu.
  static const Color glow = Color(0xFF80D8FF);

  /// Ekran zemini (dalganın oturduğu beyaz boşluk).
  static const Color surface = Color(0xFFFFFFFF);

  /// Çok açık mavi zemin (kartların ardındaki hafif tonlama).
  static const Color surfaceTint = Color(0xFFF3F7FF);

  /// Karanlık modun derin lacivert zemini (dalganın oturduğu "siyah boşluk").
  static const Color darkSurface = Color(0xFF080D1C);

  /// Karanlık modda kartların/AppBar'ın yüzeyi (bir ton açık lacivert).
  static const Color darkSurface2 = Color(0xFF141B30);

  /// Nötr kart gradyanı (aydınlık) — mavi zeminle çakışmaması için gri tonlar.
  /// Belirgin bir gri panel hissi için gradyan farkı bilinçli olarak açık.
  static const List<Color> cardGradientLight = <Color>[
    Color(0xFFF1F3F8),
    Color(0xFFCFD6E4),
  ];

  /// Nötr kart gradyanı (karanlık) — koyu lacivert-gri tonlar.
  static const List<Color> cardGradientDark = <Color>[
    Color(0xFF1C2438),
    Color(0xFF131A2B),
  ];

  /// Liste/detay kartlarının düz gri yüzeyi (aydınlık) — beyaz değil, net gri.
  static const Color cardSurfaceLight = Color(0xFFE8ECF3);

  /// Kart üzerindeki ikon rozetinin arka planı (aydınlık).
  static const Color cardBadgeLight = Color(0xFFE2E9F6);

  /// Kart kenarlığı (aydınlık) — ince ama görünür gri.
  static const Color cardBorderLight = Color(0xFFC8D0DF);

  /// Dalgada kullanılan mavi geçiş tonları (soldan sağa) — aydınlık mod.
  static const List<Color> waveGradient = <Color>[
    Color(0xFF0D47A1),
    Color(0xFF1E88E5),
    Color(0xFF42A5F5),
    Color(0xFF80D8FF),
  ];

  /// Karanlık modda dalga tonları — koyu zeminde parlayan daha aydınlık maviler.
  static const List<Color> waveGradientDark = <Color>[
    Color(0xFF1E5FCB),
    Color(0xFF2E8BF0),
    Color(0xFF4FC3F7),
    Color(0xFF9BE7FF),
  ];
}
