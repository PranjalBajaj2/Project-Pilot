import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Client Updated Successfully")),
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
      appBar: AppBar(title: const Text("Edit Client")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Client Name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Client name is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),
              TextFormField(
                controller: projectController,
                decoration: const InputDecoration(labelText: "Project Name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Project name is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: companyController,
                decoration: const InputDecoration(labelText: "Company"),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Phone"),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: notesController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: "Notes"),
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
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Update Client"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
