import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../auth/models/client_model.dart';
import '../../auth/providers/client_provider.dart';

class EditClientScreen extends StatefulWidget {
  final ClientModel client;

  const EditClientScreen({super.key, required this.client});

  @override
  State<EditClientScreen> createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController companyController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController projectController;
  late final TextEditingController notesController;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.client.name);

    companyController = TextEditingController(text: widget.client.company);

    emailController = TextEditingController(text: widget.client.email);

    phoneController = TextEditingController(text: widget.client.phone);

    addressController = TextEditingController(text: widget.client.address);

    projectController = TextEditingController(text: widget.client.project);

    notesController = TextEditingController(text: widget.client.notes);
  }

  @override
  void dispose() {
    nameController.dispose();
    companyController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    projectController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> updateClient() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isSaving = true;
    });

    final updatedClient = ClientModel(
      id: widget.client.id,
      userId: widget.client.userId,
      name: nameController.text.trim(),
      company: companyController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      project: addressController.text.trim(),
      notes: notesController.text.trim(),
      createdAt: widget.client.createdAt,
    );

    try {
      await context.read<ClientProvider>().updateClient(updatedClient);

      if (!mounted) return;

      AppSnackbar.show(
        context,
        title: "Success",
        message: "Client Updated Successfully",
        type: ContentType.success,
      );

      context.pop();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    if (mounted) {
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Client"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
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
                controller: projectController,
                decoration: const InputDecoration(
                  labelText: "Project Name",
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
                controller: companyController,
                decoration: const InputDecoration(
                  labelText: "Company",
                  prefixIcon: Icon(Icons.home_outlined),
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone",
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  prefixIcon: Icon(Icons.speaker_notes_outlined),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isSaving ? null : updateClient,
                  child: isSaving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          "Update Client",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
