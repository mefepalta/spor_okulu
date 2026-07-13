import 'package:flutter/material.dart';

/// Streak (günlük giriş serisi) görünüm stili — seri gün sayısına göre renk ve
/// alev rozeti. Hem ana ekran göstergesinde hem global chat isim renginde
/// kullanılır ki ödül her yerde tutarlı görünsün.
class StreakStyle {
  /// Tier rengi; null ise normal (varsayılan metin) renk kullanılır.
  final Color? color;

  /// Alev rozeti gösterilsin mi (yalnızca 3+ günde).
  final bool showBadge;

  const StreakStyle(this.color, this.showBadge);
}

/// Renkler [AppColors]/palet ile uyumlu, hem açık hem koyu temada okunur tonlar.
StreakStyle streakStyle(int streak) {
  if (streak >= 30) {
    return const StreakStyle(Color(0xFFEF9F27), true); // altın
  }
  if (streak >= 14) {
    return const StreakStyle(Color(0xFF7F77DD), true); // mor
  }
  if (streak >= 7) {
    return const StreakStyle(Color(0xFF378ADD), true); // mavi
  }
  if (streak >= 3) {
    return const StreakStyle(Color(0xFF1D9E75), true); // turkuaz
  }
  return const StreakStyle(null, false);
}
