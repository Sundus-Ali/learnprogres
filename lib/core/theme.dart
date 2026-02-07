import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color charcoalBlue = Color(0xFF2C3E50); // Primary
  static const Color dustyDenim = Color(0xFF5D8AA8); // Secondary
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: charcoalBlue,
      scaffoldBackgroundColor: white,
      colorScheme: ColorScheme.light(
        primary: charcoalBlue,
        secondary: dustyDenim,
        surface: white,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: charcoalBlue,
        foregroundColor: white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: charcoalBlue,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
