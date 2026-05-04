import 'package:flutter/material.dart';

/// App-wide constants for theme, colors, and spacing
class Constants {
  // Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF4F46E5);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color accentColor = Color(0xFF00D4FF);

  // App dimensions
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;

  // API endpoints
  static const String replicateApiBase = 'https://api.replicate.com/v1';

  // Image dimensions
  static const int imageWidth = 512;
  static const int imageHeight = 512;

  // Generation settings
  static const int defaultSteps = 50;
  static const String defaultModel = 'flux';
}
