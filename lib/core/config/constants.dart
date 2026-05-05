import 'package:flutter/material.dart';

/// App-wide constants for theme, colors, and spacing
class Constants {
  // Brand Colors - Vibrant creative tool palette
  static const Color primaryColor = Color(0xFF7C3AED);       // Electric violet
  static const Color secondaryColor = Color(0xFFEC4899);    // Hot pink
  static const Color accentColor = Color(0xFF06B6D4);       // Cyan
  static const Color gradientStart = Color(0xFF8B5CF6);     // Purple
  static const Color gradientEnd = Color(0xFFEC4899);       // Pink
  
  // Dark theme surfaces
  static const Color backgroundColor = Color(0xFF0F0F1A);    // Deep space
  static const Color surfaceColor = Color(0xFF1A1A2E);       // Card background
  static const Color surfaceLight = Color(0xFF252540);      // Elevated surface
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA1A1AA);      // Muted text
  static const Color textMuted = Color(0xFF71717A);
  
  // Status colors
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF1A1A2E), Color(0xFF0F0F1A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // App dimensions
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacing2xl = 48.0;
  static const double borderRadiusSm = 8.0;
  static const double borderRadiusMd = 12.0;
  static const double borderRadiusLg = 16.0;
  static const double borderRadiusXl = 24.0;
  static const double cardElevation = 0.0;

  // API endpoints
  static const String replicateApiBase = 'https://api.replicate.com/v1';

  // Image dimensions
  static const int imageWidth = 1024;
  static const int imageHeight = 1024;

  // Generation settings
  static const int defaultSteps = 50;
  static const String defaultModel = 'flux';
}
