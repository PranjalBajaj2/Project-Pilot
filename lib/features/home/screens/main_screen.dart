import 'package:flutter/material.dart';
import 'package:projectpilot/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme_provider.dart';
import '../../../shared/navigation/mobile_navigation.dart';
import '../../../shared/navigation/desktop_navigation.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../models/clients/clients.dart';
import '../../dashboard.dart';
import '../../models/navigation_item.dart';
import '../../models/payments/payments.dart';
import '../../models/profile/profile.dart';
import '../../models/projects/projects.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  late final List<NavigationItem> items;

  @override
  void initState() {
    super.initState();

    items = [

      const NavigationItem(
        title: "Dashboard",
        icon: Icons.home_outlined,
        page: DashboardScreen(),
      ),

      const NavigationItem(
        title: "Clients",
        icon: Icons.people_outline,
        page: ClientsScreen(),
      ),

      const NavigationItem(
        title: "Projects",
        icon: Icons.folder_copy_outlined,
        page: ProjectsScreen(),
      ),

      const NavigationItem(
        title: "Payments",
        icon: Icons.payments_outlined,
        page: PaymentsScreen(),
      ),

      const NavigationItem(
        title: "Profile",
        icon: Icons.person_outline,
        page: ProfileScreen(),
      ),




    ];
  }

  bool get isDesktop =>
      MediaQuery.of(context).size.width >= 900;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Theme(
        data: themeProvider.themeMode == ThemeMode.dark
            ? AppThemeDark.darkTheme
            : AppThemeLight.lightTheme,

        child: Scaffold(

      appBar: CustomAppBar(
          icon: items[currentIndex].icon,
          title: items[currentIndex].title,

              ),

      body: isDesktop
          ? Row(
        children: [

          DesktopNavigation(
            currentIndex: currentIndex,
            items: items,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),



          const VerticalDivider(width: 1),

          Expanded(
            child: items[currentIndex].page,
          ),

        ],
      )
          : items[currentIndex].page,

      bottomNavigationBar: isDesktop
          ? null
          : MobileNavigation(
        currentIndex: currentIndex,
        items: items,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
        ),
    );
  }
}