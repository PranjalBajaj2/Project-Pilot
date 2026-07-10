import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    return NavigationRail(

      selectedIndex: currentIndex,

      onDestinationSelected: onTap,

      labelType: NavigationRailLabelType.all,
      indicatorColor: AppColors.primary,

      destinations: items
          .map(
            (e) => NavigationRailDestination(
          icon: Icon(e.icon),
          label: Text(e.title),
        ),
      )
          .toList(),
    );


  }
}