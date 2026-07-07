import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  /// Aydınlık tema. Marka kimliği (AppBar/buton) şimdilik indigo kalır.
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  /// Karanlık tema. Derin lacivert zemin + parlak mavi vurgular; dalga arka
  /// planı bu modda ilk referanstaki gibi koyu zeminde parlar.
  static ThemeData get darkTheme {
    final scheme = ColorScheme.fromSeed(
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
      cardTheme: const CardThemeData(color: AppColors.darkSurface2),
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
