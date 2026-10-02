import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_radius.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ).copyWith(
        surface: AppColors.surface, // override generic surface mapping
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.screenTitle,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mediumRadius,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: AppTypography.display,
        headlineLarge: AppTypography.hero,
        titleLarge: AppTypography.screenTitle,
        titleMedium: AppTypography.sectionTitle,
        titleSmall: AppTypography.cardTitle,
        bodyLarge: AppTypography.body,
        bodyMedium: AppTypography.bodySmall,
        labelSmall: AppTypography.metadata,
        labelLarge: AppTypography.button,
      ),
    );
  }
}
