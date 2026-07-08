import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  /// Aydınlık tema. Marka kimliği tek bir mavide (AppColors.primary) birleşir:
  /// AppBar, buton, FAB ve içerik aksanları aynı tonu kullanır.
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surface,
      // Tüm kartlar (liste, detay, profil) nötr beyaz yüzey + yuvarlak köşe +
      // ince kenarlık + yumuşak gölge; mavi zeminle çakışmaz.
      cardTheme: CardThemeData(
        color: AppColors.cardSurfaceLight,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: const Color(0xFF1A2542).withValues(alpha: 0.22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.cardBorderLight),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  /// Karanlık tema. Derin lacivert zemin + parlak mavi vurgular; dalga arka
  /// planı bu modda ilk referanstaki gibi koyu zeminde parlar.
  static ThemeData get darkTheme {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ).copyWith(
          surface: AppColors.darkSurface,
          surfaceContainerLowest: AppColors.darkSurface,
          surfaceContainer: AppColors.darkSurface2,
          surfaceContainerHigh: AppColors.darkSurface2,
        );

    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkSurface,
      cardColor: AppColors.darkSurface2,
      cardTheme: CardThemeData(
        color: AppColors.darkSurface2,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface2,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.mid,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mid,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
