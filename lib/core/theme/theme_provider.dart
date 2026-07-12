import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _themeKey = "theme_mode";

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_themeKey) ?? "system";

    switch (value) {
      case "light":
        _themeMode = ThemeMode.light;
        break;

      case "dark":
        _themeMode = ThemeMode.dark;
        break;

      default:
        _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    switch (mode) {
      case ThemeMode.light:
        await prefs.setString(_themeKey, "light");
        break;

      case ThemeMode.dark:
        await prefs.setString(_themeKey, "dark");
        break;

      case ThemeMode.system:
        await prefs.setString(_themeKey, "system");
        break;
    }
  }
}