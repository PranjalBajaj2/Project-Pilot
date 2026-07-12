import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/shared/profile_widgets/setting_tile.dart';
import 'package:projectpilot/shared/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../features/auth/providers/profile_provider.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final user = provider.user!;
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      backgroundColor: themeProvider.isDark
          ? AppColorsDark.secondary
          : AppColorsLight.surface,
      appBar: CustomAppBar(title: "Profile"),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ProfileInfoTile(icon: Icons.person, title: "Name", value: user.name),

          ProfileInfoTile(icon: Icons.email, title: "Email", value: user.email),

          ProfileInfoTile(
            icon: Icons.phone,
            title: "Phone",
            value: user.phone!,
          ),

          SettingsTile(
            icon: Icons.edit,
            title: "Edit Profile",
            onTap: () {
              context.push('/edit-profile', extra: user);
            },
          ),
        ],
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? value;
  final VoidCallback? onTap;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value!),
        onTap: onTap,
      ),
    );
  }
}
