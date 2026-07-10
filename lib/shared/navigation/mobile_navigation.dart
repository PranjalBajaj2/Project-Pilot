import 'package:flutter/material.dart';
import 'package:projectpilot/core/theme/app_colors.dart';

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

    return NavigationBar(

      selectedIndex: currentIndex,

      onDestinationSelected: onTap,
      indicatorColor: AppColors.primary,

      destinations: items
          .map(
            (e) => NavigationDestination(
          icon: Icon(e.icon),
          label: (e.title),
        ),

      )
          .toList(),
    );
  }
}