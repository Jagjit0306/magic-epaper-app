import 'package:flutter/material.dart';
import 'package:magicepaperapp/theme/colors.dart';
import 'package:magicepaperapp/theme/typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(Color accentColor) =>
      _buildTheme(accentColor, Brightness.light);

  static ThemeData darkTheme(Color accentColor) =>
      _buildTheme(accentColor, Brightness.dark);

  static ThemeData _buildTheme(Color accentColor, Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: brightness,
    );
    final isDark = brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF1E1E1E) : surfaceColor;
    final fieldFill = isDark ? const Color(0xFF2A2A2A) : grey50;
    final borderColor = isDark ? const Color(0xFF555555) : grey300;

    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      primaryColor: accentColor,
      primarySwatch: brandSwatch,
      scaffoldBackgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        titleTextStyle: AppTypography.dialogTitle.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fieldFill,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        floatingLabelStyle:
            AppTypography.floatingLabel.copyWith(color: accentColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 2),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.onSurfaceVariant,
          textStyle: AppTypography.textButton,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: onPrimaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          textStyle: AppTypography.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurfaceVariant,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          textStyle: AppTypography.button,
        ),
      ),
    );
  }
}
