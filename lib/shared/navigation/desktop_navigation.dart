import 'package:flutter/material.dart';

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