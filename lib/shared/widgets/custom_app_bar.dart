import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectpilot/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;

  const CustomAppBar({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: GoogleFonts.quicksand(fontSize: 30)),
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppColorsLight.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
