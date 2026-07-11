import 'package:flutter/material.dart';
import 'package:projectpilot/features/auth/providers/project_provider.dart';
import 'package:provider/provider.dart';

class RecentProjectTile extends StatelessWidget {
  final String title;
  final String client;

  const RecentProjectTile({
    super.key,
    required this.title,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: const CircleAvatar(child: Icon(Icons.folder_copy_outlined)),

      title: Text(title),

      subtitle: Text(client),
    );
  }
}
