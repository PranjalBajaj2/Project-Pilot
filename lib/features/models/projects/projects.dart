import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/core/theme/app_colors.dart';
import 'package:projectpilot/shared/project_widgets/project_card.dart';
import 'package:provider/provider.dart';


import '../../../routes/route_names.dart';
import '../../auth/providers/project_provider.dart';

class ProjectsScreen extends StatefulWidget {
  const  ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProjectProvider>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Add new project",
        hoverColor: AppColorsLight.primary,
        onPressed: () {
          context.push(RouteNames.addProject);
        },

        child: const Icon(Icons.create_new_folder_rounded),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: searchController,

              onChanged: provider.searchProject,

              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),

                hintText: "Search Project",
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
                    return Center(
                      child: Text(provider.error!),
                    );
                  }

                  if (provider.projects.isEmpty) {
                    return const Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_copy_outlined,size: 100,),
                        Text("No Projects Found",style: TextStyle(fontSize: 25),)
                      ],
                    ));
                  }

                  return ListView.builder(
                    itemCount: provider.projects.length,
                    itemBuilder: (context, index) {
                      final project = provider.projects[index];

                      return ProjectTile(
                          project: project,
                          onEdit: () {
                            context.push('/edit-project', extra: project);
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
