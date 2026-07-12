import 'package:flutter/material.dart';
import 'package:projectpilot/core/theme/app_colors.dart';
import 'package:projectpilot/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../features/models/navigation_item.dart';

class MobileNavigation extends StatelessWidget {
  final int currentIndex;
  final List<NavigationItem> items;
  final Function(int) onTap;

  const MobileNavigation({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return NavigationBar(
      selectedIndex: currentIndex,

      onDestinationSelected: onTap,
      indicatorColor: AppColorsLight.primary,
      backgroundColor: themeProvider.isDark
          ? AppColorsDark.background
          : AppColorsLight.background,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: themeProvider.isDark
                ? AppColorsDark.textSecondary
                : AppColorsLight.textPrimary,
          );
        }

        return TextStyle(
          color: themeProvider.isDark
              ? AppColorsDark.textSecondary
              : AppColorsLight.textPrimary,
        );
      }),

      destinations: items
          .map(
            (e) => NavigationDestination(
              icon: Icon(
                e.icon,
                color: themeProvider.isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textPrimary,
              ),
              label: (e.title),
            ),
          )
          .toList(),
    );
  }
}
