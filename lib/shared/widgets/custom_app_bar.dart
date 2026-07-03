import 'package:flutter/material.dart';
import 'package:projectpilot/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Text(title),
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppColors.primary,
    );

  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}