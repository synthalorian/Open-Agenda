import 'package:flutter/material.dart';

/// Open Agenda Color System
/// Neon synthwave aesthetic with modern accessibility
class AppColors {
  AppColors._();

  // Primary Neon Colors
  static const Color neonPink = Color(0xFF4F46E5);      // Indigo - professional primary for EdTech
  static const Color neonCyan = Color(0xFF00F5FF);
  static const Color neonPurple = Color(0xFF8B5CF6);
  static const Color neonBlue = Color(0xFF3B82F6);
  static const Color neonGreen = Color(0xFF00FF88);
  static const Color neonOrange = Color(0xFFFF6B35);
  static const Color neonYellow = Color(0xFFFFD60A);

  // Synthwave '84 Palette (matches Omarchy dark theme)
  static const Color sw84Background = Color(0xFF240037);
  static const Color sw84Surface = Color(0xFF1A002A);
  static const Color sw84Card = Color(0xFF2D0045);
  static const Color sw84Elevated = Color(0xFF3A0058);
  static const Color sw84Purple = Color(0xFF8F00FF);
  static const Color sw84Yellow = Color(0xFFF3E70F);
  static const Color sw84Pink = Color(0xFFFF00FF);
  static const Color sw84PinkSoft = Color(0xFFFF7EDB);
  static const Color sw84Cyan = Color(0xFF03EDF9);
  static const Color sw84Blue = Color(0xFF0080FF);
  static const Color sw84Red = Color(0xFFFF0040);
  static const Color sw84Text = Color(0xFFFFFFFF);
  static const Color sw84TextDim = Color(0xFFB0A0C0);

  // Background Colors - Dark Mode (Synthwave '84)
  static const Color darkBackground = Color(0xFF240037);
  static const Color darkSurface = Color(0xFF1A002A);
  static const Color darkCard = Color(0xFF2D0045);
  static const Color darkElevated = Color(0xFF3A0058);

  // Background Colors - Light Mode
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F5F7);
  static const Color lightElevated = Color(0xFFEBEBF0);

  // Gradient Definitions
  static const LinearGradient neonGradient = LinearGradient(
    colors: [sw84Purple, sw84Pink, sw84Cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [neonOrange, sw84Pink, sw84Purple],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient synthwaveGradient = LinearGradient(
    colors: [sw84Purple, sw84Pink, sw84Yellow],
    begin: Alignment(-1, -1),
    end: Alignment(1, 1),
    stops: [0.0, 0.5, 1.0],
  );

  // Synthwave '84 gradient for dark theme
  static const LinearGradient sw84Gradient = LinearGradient(
    colors: [sw84Purple, sw84Pink, sw84Cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glassmorphism
  static const Color glassLight = Color(0x1AFFFFFF);
  static const Color glassDark = Color(0x1A000000);
  static const Color glassBorder = Color(0x33FFFFFF);

  // Semantic Colors
  static const Color success = Color(0xFF00FF88);
  static const Color warning = Color(0xFFFFD60A);
  static const Color error = Color(0xFFFF006E);
  static const Color info = Color(0xFF00F5FF);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB3FFFFFF);
  static const Color textTertiary = Color(0x66FFFFFF);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textDarkSecondary = Color(0x991A1A2E);

  // Educational Colors (for different subjects/types)
  static const Color mathColor = Color(0xFF3B82F6);      // Blue
  static const Color scienceColor = Color(0xFF00FF88);    // Green
  static const Color englishColor = Color(0xFFFF006E);    // Pink
  static const Color historyColor = Color(0xFFFF6B35);    // Orange
  static const Color artColor = Color(0xFF8B5CF6);        // Purple
  static const Color musicColor = Color(0xFF00F5FF);      // Cyan
  static const Color peColor = Color(0xFFFFD60A);         // Yellow

  // Special Education Colors
  static const Color iepColor = Color(0xFF8B5CF6);
  static const Color accommodationColor = Color(0xFF00F5FF);
  static const Color goalColor = Color(0xFF00FF88);
}

/// Synthwave '84 Dark Theme Color Scheme
class DarkColorScheme extends ColorScheme {
  DarkColorScheme()
      : super(
          brightness: Brightness.dark,
          primary: AppColors.sw84Purple,
          onPrimary: AppColors.sw84Text,
          primaryContainer: AppColors.sw84Elevated,
          onPrimaryContainer: AppColors.sw84Purple,
          secondary: AppColors.sw84Yellow,
          onSecondary: AppColors.sw84Background,
          secondaryContainer: AppColors.sw84Elevated,
          onSecondaryContainer: AppColors.sw84Yellow,
          tertiary: AppColors.sw84Pink,
          onTertiary: AppColors.sw84Text,
          surface: AppColors.sw84Surface,
          onSurface: AppColors.sw84Text,
          surfaceContainerHighest: AppColors.sw84Card,
          error: AppColors.sw84Red,
          onError: AppColors.sw84Text,
          errorContainer: AppColors.sw84Elevated,
          outline: AppColors.sw84Purple.withAlpha(51),
          outlineVariant: AppColors.sw84TextDim,
        );
}

/// Light Theme Color Scheme
class LightColorScheme extends ColorScheme {
  LightColorScheme()
      : super(
          brightness: Brightness.light,
          primary: AppColors.neonPink,
          onPrimary: AppColors.textPrimary,
          primaryContainer: const Color(0xFFFFE5EF),
          onPrimaryContainer: AppColors.neonPink,
          secondary: AppColors.neonCyan,
          onSecondary: AppColors.textDark,
          secondaryContainer: const Color(0xFFE5FFFF),
          onSecondaryContainer: AppColors.neonCyan,
          tertiary: AppColors.neonPurple,
          onTertiary: AppColors.textPrimary,
          surface: AppColors.lightSurface,
          onSurface: AppColors.textDark,
          surfaceContainerHighest: AppColors.lightCard,
          error: AppColors.error,
          onError: AppColors.textPrimary,
          errorContainer: const Color(0xFFFFE5EF),
          outline: const Color(0x33000000),
          outlineVariant: AppColors.textDarkSecondary,
        );
}
