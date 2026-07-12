import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/features/auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../routes/route_names.dart';
import '../../../shared/profile_widgets/setting_tile.dart';
import '../../auth/providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final user = provider.user!;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 40,
                child: Text(
                  user.name[0].toUpperCase(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                ),
              ),

              SizedBox(height: 15),

              Text(
                user.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(height: 5),

              Text(user.email, style: TextStyle(color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 30),

          SettingsTile(
            icon: Icons.key,
            title: "Account",
            onTap: () {
              context.push('/profile');
            },
          ),

          const SizedBox(height: 10),

          // SettingsTile(icon: Icons.border_color,
          //   title: "Preferences",
          //   onTap: (){
          //     context.push('/profile');
          //   },),
          Text("Preferences", style: Theme.of(context).textTheme.titleLarge),

          const SizedBox(height: 15),

          SettingsTile(
            icon: Icons.dark_mode,
            title: "Dark Mode",
            onTap: () {
              context.push('/theme');
            },
          ),

          SettingsTile(icon: Icons.currency_exchange, title: "Currency"),

          SettingsTile(icon: Icons.notifications, title: "Notifications"),

          SettingsTile(
            icon: Icons.logout,

            title: "Logout",

            onTap: () {
              showDialog(
                context: context,

                builder: (_) {
                  return AlertDialog(
                    title: const Text("Logout"),

                    content: const Text("Are you sure you want to logout?"),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Text("Cancel"),
                      ),

                      FilledButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          await context.read<AuthProvider>().logout();

                          if (!context.mounted) return;

                          context.go(RouteNames.login);
                        },

                        child: const Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          const SizedBox(height: 30),

          Text("Security", style: Theme.of(context).textTheme.titleLarge),

          const SizedBox(height: 15),

          SettingsTile(
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {
              context.push('/change-password');
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
