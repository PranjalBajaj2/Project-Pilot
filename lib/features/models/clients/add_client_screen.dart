import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectpilot/core/theme/theme_provider.dart';
import 'package:projectpilot/shared/widgets/custom_app_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../../auth/models/client_model.dart';
import '../../auth/providers/client_provider.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final company = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final project = TextEditingController();
  final notes = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    company.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    notes.dispose();
    project.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      backgroundColor: themeProvider.isDark
          ? AppColorsDark.secondary
          : AppColorsLight.surface,
      appBar: CustomAppBar(title: "Add Client"),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: "Client Name",
                  prefixIcon: Icon(Icons.person_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Client name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: project,
                decoration: const InputDecoration(
                  labelText: "Client Project",
                  prefixIcon: Icon(Icons.folder_copy_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Project name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: company,
                decoration: const InputDecoration(
                  labelText: "Company",
                  prefixIcon: Icon(Icons.home_outlined),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: phone,
                decoration: const InputDecoration(
                  labelText: "Phone",
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: address,
                decoration: const InputDecoration(
                  labelText: "Address",
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: notes,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  prefixIcon: Icon(Icons.speaker_notes_outlined),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final client = ClientModel(
                    id: "",

                    userId: FirebaseAuth.instance.currentUser!.uid,

                    name: name.text,

                    company: company.text,

                    email: email.text,

                    phone: phone.text,

                    address: address.text,

                    notes: notes.text,
                    project: project.text,

                    createdAt: Timestamp.now(),
                  );

                  await context.read<ClientProvider>().addClient(client);

                  if (!mounted) return;
                  AppSnackbar.show(
                    context,
                    title: "Success",
                    message: "Client Added Successfully",
                    type: ContentType.success,
                  );

                  Navigator.pop(context);
                },

                child: const Text(
                  "Save Client",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
