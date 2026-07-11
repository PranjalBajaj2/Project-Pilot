import 'package:flutter/material.dart';
import 'package:projectpilot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../../features/auth/models/client_model.dart';
import '../../features/auth/providers/client_provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../widgets/app_snackbar.dart';

class ClientTile extends StatefulWidget {
  final ClientModel client;
  final VoidCallback onEdit;

  const ClientTile({super.key, required this.client, required this.onEdit});

  @override
  State<ClientTile> createState() => _ClientTileState();
}

class _ClientTileState extends State<ClientTile> {
  bool expanded = false;

  String value(String? text) {
    if (text == null) return "—";

    if (text.trim().isEmpty) {
      return "—";
    }

    return text;
  }

  Widget buildRow(String title, String? valueText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value(valueText))),
        ],
      ),
    );
  }

  Future<void> deleteClient() async {
    final provider = Provider.of<ClientProvider>(context, listen: false);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Client"),
          content: const Text("Are you sure you want to delete this client?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await provider.deleteClient(widget.client.id);

      if (mounted) {
        AppSnackbar.show(
          context,
          title: "Client",
          message: "Deleted Successfully",
          type: ContentType.success,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = widget.client;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(child: Text(client.name![0].toUpperCase())),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value(client.name?.toUpperCase()),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          value(client.project),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  const Divider(),

                  buildRow("Client Name:", client.name),
                  buildRow("Project:", client.project),
                  buildRow("Email:", client.email),
                  buildRow("Phone:", client.phone),
                  buildRow("Company:", client.company),
                  buildRow("Address:", client.address),
                  buildRow("Notes:", client.notes),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: widget.onEdit,
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.error,
                          ),
                          onPressed: deleteClient,
                          icon: const Icon(Icons.delete),
                          label: const Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
