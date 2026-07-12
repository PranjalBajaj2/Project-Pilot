import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme_provider.dart';
import '../../core/theme/app_colors.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ThemeProvider>();
    return Scaffold(
      backgroundColor: provider.isDark
          ? AppColorsDark.secondary
          : AppColorsLight.surface,
      appBar: AppBar(title: const Text("Appearance")),
      body: ListView(
        children: [
          RadioListTile<ThemeMode>(
            title: Text(
              "Light",
              style: TextStyle(
                color: provider.isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textPrimary,
              ),
            ),
            value: ThemeMode.light,
            groupValue: provider.themeMode,
            onChanged: (value) {
              if (value != null) {
                provider.setTheme(value);
                context.push(RouteNames.main);
              }
            },
          ),

          RadioListTile<ThemeMode>(
            title: Text(
              "Dark",
              style: TextStyle(
                color: provider.isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textPrimary,
              ),
            ),
            value: ThemeMode.dark,
            groupValue: provider.themeMode,
            onChanged: (value) {
              if (value != null) {
                provider.setTheme(value);
                context.push(RouteNames.main);
              }
            },
          ),
        ],
      ),
    );
  }
}
