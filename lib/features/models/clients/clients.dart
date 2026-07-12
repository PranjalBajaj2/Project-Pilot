import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/client_widgets/client_card.dart';
import '../../auth/providers/client_provider.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClientProvider>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Add new Client",
        hoverColor: AppColorsLight.primary,
        onPressed: () {
          context.push(RouteNames.addClient);
        },

        child: const Icon(Icons.person_add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: searchController,

              onChanged: provider.searchClient,

              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),

                hintText: "Search Client",
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Builder(
                builder: (_) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.error != null) {
                    return Center(child: Text(provider.error!));
                  }

                  if (provider.clients.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_outline, size: 100),
                          Text(
                            "No Clients Found",
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.clients.length,
                    itemBuilder: (context, index) {
                      final client = provider.clients[index];

                      return ClientTile(
                        client: client,
                        onEdit: () {
                          context.push('/edit-client', extra: client);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
