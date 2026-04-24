import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF131313),
      primaryColor: const Color(0xFFFFFFFF),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFFFFFF),
        onPrimary: Color(0xFF2F3131),
        secondary: Color(0xFFD0BCFF),
        onSecondary: Color(0xFF3C0091),
        surface: Color(0xFF131313),
        onSurface: Color(0xFFE5E2E1),
        surfaceContainerHighest: Color(0xFF353534), // using an extension if needed
        error: Color(0xFFFFB4AB),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          height: 34 / 28,
          letterSpacing: -0.02,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          height: 28 / 22,
          letterSpacing: -0.01,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          height: 24 / 17,
          letterSpacing: -0.01,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
          letterSpacing: 0,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16 / 12,
          letterSpacing: 0.02,
        ),
      ),
      useMaterial3: true,
    );
  }

  // Custom colors not strictly in ColorScheme
  static const Color surfaceContainerHighest = Color(0xFF353534);
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);
  static const Color surfaceContainer = Color(0xFF201F1F);
  static const Color surfaceContainerLow = Color(0xFF1C1B1B);
  static const Color onSurfaceVariant = Color(0xFFC4C7C8);
  static const Color outlineVariant = Color(0xFF444748);
  static const Color primaryContainer = Color(0xFFE2E2E2);
  static const Color tertiaryFixed = Color(0xFF9CF0FF);
  static const Color secondaryFixed = Color(0xFFE9DDFF);
}
