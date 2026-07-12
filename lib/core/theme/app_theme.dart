import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/widgets/custon_text.dart';
import 'app_colors.dart';

class AppThemeLight {
  AppThemeLight._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColorsLight.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColorsLight.primary,
      brightness: Brightness.light,
    ),


    textTheme: AppTextTheme.lightTextTheme,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColorsLight.primary,
      foregroundColor: AppColorsLight.textPrimary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColorsLight.border),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColorsLight.border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColorsLight.primary, width: 1.4),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        backgroundColor: AppColorsLight.primary,
        foregroundColor: AppColorsLight.textPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}

class AppThemeDark {
  AppThemeDark._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColorsDark.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColorsDark.primary,
      brightness: Brightness.light,
    ),


    textTheme: AppTextTheme.darkTextTheme,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: AppColorsDark.primary,
      foregroundColor: AppColorsDark.textPrimary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColorsDark.border),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColorsDark.border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColorsDark.border, width: 1.4),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        backgroundColor: AppColorsDark.primary,
        foregroundColor: AppColorsDark.textPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
