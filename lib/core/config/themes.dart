import 'package:flutter/material.dart';
import 'constants.dart';

/// Material 3 dark theme for PhotoPrompt AI - Premium creative tool aesthetic
class Themes {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Constants.primaryColor,
      scaffoldBackgroundColor: Constants.backgroundColor,
      cardColor: Constants.surfaceColor,
      dividerColor: Constants.surfaceLight,
      
      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Constants.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: Constants.textPrimary),
      ),
      
      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Constants.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -1,
        ),
        displayMedium: TextStyle(
          color: Constants.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineLarge: TextStyle(
          color: Constants.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: Constants.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: Constants.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: Constants.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(color: Constants.textSecondary, fontSize: 16),
        bodyMedium: TextStyle(color: Constants.textSecondary, fontSize: 14),
        bodySmall: TextStyle(color: Constants.textMuted, fontSize: 12),
      ),
      
      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: Constants.primaryColor,
        secondary: Constants.secondaryColor,
        tertiary: Constants.accentColor,
        surface: Constants.surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Constants.textPrimary,
        error: Constants.errorColor,
      ),
      
      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Constants.surfaceLight,
        hintStyle: const TextStyle(color: Constants.textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
          borderSide: const BorderSide(color: Constants.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
          borderSide: const BorderSide(color: Constants.errorColor, width: 1),
        ),
      ),
      
      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Constants.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Constants.textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadiusMd),
          ),
          side: const BorderSide(color: Constants.surfaceLight, width: 1.5),
        ),
      ),
      
      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Constants.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      
      // Card theme
      cardTheme: CardTheme(
        color: Constants.surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadiusLg),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Constants.surfaceLight,
        contentTextStyle: const TextStyle(color: Constants.textPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadiusSm),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Icon theme
      iconTheme: const IconThemeData(
        color: Constants.textSecondary,
        size: 24,
      ),
      
      // Progress indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Constants.primaryColor,
        linearTrackColor: Constants.surfaceLight,
      ),
    );
  }
}
