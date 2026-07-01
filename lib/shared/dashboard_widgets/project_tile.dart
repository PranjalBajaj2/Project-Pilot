import 'package:flutter/material.dart';

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

      leading: const CircleAvatar(
        child: Icon(Icons.folder_open),
      ),

      title: Text(title),

      subtitle: Text(client),

      trailing: const Icon(Icons.arrow_forward_ios,size:16),

    );

  }
}