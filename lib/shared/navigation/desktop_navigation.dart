import 'package:flutter/material.dart';
import 'package:projectpilot/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../features/models/navigation_item.dart';

class DesktopNavigation extends StatelessWidget {
  final int currentIndex;
  final List<NavigationItem> items;
  final Function(int) onTap;

  const DesktopNavigation({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return NavigationRail(
      selectedIndex: currentIndex,

      onDestinationSelected: onTap,

      labelType: NavigationRailLabelType.all,
      indicatorColor: AppColorsLight.primary,
      backgroundColor: themeProvider.isDark
          ? AppColorsDark.background
          : AppColorsLight.background,

      destinations: items
          .map(
            (e) => NavigationRailDestination(
              icon: Icon(
                e.icon,
                color: themeProvider.isDark
                    ? AppColorsDark.textSecondary
                    : AppColorsLight.textPrimary,
              ),
              label: Text(
                e.title,
                style: TextStyle(
                  color: themeProvider.isDark
                      ? AppColorsDark.textSecondary
                      : AppColorsLight.textPrimary,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
