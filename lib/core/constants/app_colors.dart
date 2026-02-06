import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Gradient Colors - Electric Blue & Purple
  static const Color primaryStart = Color(0xFF6366f1);
  static const Color primaryMid = Color(0xFF8b5cf6);
  static const Color primaryEnd = Color(0xFFa855f7);

  // Secondary Gradient Colors - Cyan & Blue
  static const Color secondaryStart = Color(0xFF06b6d4);
  static const Color secondaryMid = Color(0xFF3b82f6);
  static const Color secondaryEnd = Color(0xFF6366f1);

  // Player X Colors (Indigo/Purple)
  static const Color playerXLight = Color(0xFF818cf8);
  static const Color playerXDark = Color(0xFF6366f1);
  static const Color playerXAccent = Color(0xFF4f46e5);

  // Player O Colors (Emerald/Cyan)
  static const Color playerOLight = Color(0xFF34d399);
  static const Color playerOMid = Color(0xFF10b981);
  static const Color playerODark = Color(0xFF059669);

  // Background Colors - Dark Mode
  static const Color backgroundDark = Color(0xFF0a0a0f);
  static const Color backgroundMid = Color(0xFF111118);
  static const Color backgroundLight = Color(0xFF1a1a24);

  // Surface Colors
  static const Color surfaceDark = Color(0xFF16161f);
  static const Color surfaceMid = Color(0xFF1e1e2d);
  static const Color surfaceLight = Color(0xFF252535);

  // Cell Colors
  static const Color cellBackground = Color(0xFF1e1e2d);
  static const Color cellBorder = Color(0xFF2d2d3f);
  static const Color cellHover = Color(0xFF2d2d45);
  static const Color cellActive = Color(0xFF3a3a52);

  // Text Colors
  static const Color textPrimary = Color(0xFFf8fafc);
  static const Color textSecondary = Color(0xFFcbd5e1);
  static const Color textTertiary = Color(0xFF94a3b8);
  static const Color textMuted = Color(0xFF64748b);

  // Status Colors
  static const Color success = Color(0xFF22c55e);
  static const Color warning = Color(0xFFf59e0b);
  static const Color error = Color(0xFFef4444);
  static const Color info = Color(0xFF3b82f6);

  // Special Effects
  static const Color glowPurple = Color(0xFF8b5cf6);
  static const Color glowCyan = Color(0xFF06b6d4);
  static const Color glowPink = Color(0xFFec4899);
  static const Color shadowDark = Color(0xFF000000);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryStart, primaryMid, primaryEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryStart, secondaryMid, secondaryEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [backgroundDark, backgroundMid, backgroundLight],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient playerXGradient = LinearGradient(
    colors: [playerXLight, playerXDark, playerXAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient playerOGradient = LinearGradient(
    colors: [playerOLight, playerOMid, playerODark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [surfaceDark, surfaceMid],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient winGradient = LinearGradient(
    colors: [success, Color(0xFF84cc16)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const RadialGradient glowGradient = RadialGradient(
    colors: [glowPurple, Colors.transparent],
    stops: [0.0, 1.0],
  );

  // Shimmer Gradient for animations
  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [
      Color(0xFF1e1e2d),
      Color(0xFF2d2d45),
      Color(0xFF1e1e2d),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
}