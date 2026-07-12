import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    headlineLarge: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    headlineMedium: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),

    titleLarge: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      color: Colors.black87,
    ),

    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      color: Colors.black87,
    ),

    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      color: Colors.black54,
    ),

    labelLarge: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    headlineLarge: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    headlineMedium: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),

    titleLarge: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      color: Colors.black,
    ),

    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      color: Colors.black,

    ),

    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      color: Colors.black,
    ),

    labelLarge: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );
}