import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectpilot/features/auth/models/project_model.dart';
import 'package:projectpilot/features/auth/providers/project_provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:projectpilot/shared/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../../auth/models/client_model.dart';
import '../../auth/providers/client_provider.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  final projectNameController = TextEditingController();

  final descriptionController = TextEditingController();

  final budgetController = TextEditingController();
  ClientModel? selectedClient;

  String selectedCurrency = "PKR";

  String selectedStatus = "Pending";

  DateTime? startDate;
  DateTime? deadline;

  static const currencies = ["PKR", "USD", "EUR", "GBP"];
  static const statuses = ["Pending", "In Progress", "Completed", "Cancelled"];
  bool isLoading = false;

  @override
  void dispose() {
    projectNameController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clients = context.watch<ClientProvider>().clients;
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      backgroundColor: themeProvider.isDark
          ? AppColorsDark.secondary
          : AppColorsLight.surface,
      appBar: CustomAppBar(title: "Add Project"),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              TextFormField(
                controller: projectNameController,
                decoration: const InputDecoration(
                  labelText: "Project Name",
                  prefixIcon: Icon(Icons.insert_drive_file_outlined),
                ),
                validator: (v) =>
                    v!.isEmpty ? "Project Name is Required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Project Description",
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (v) => v!.isEmpty ? "Description is Required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Project Budget",
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Budget is required";
                  }

                  if (double.tryParse(value) == null) {
                    return "Enter valid budget";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: pickStartDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: "Start Date",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event),
                  ),
                  child: Text(
                    startDate == null
                        ? "Select Start Date"
                        : "${startDate!.day}/${startDate!.month}/${startDate!.year}",
                  ),
                ),
              ),

              const SizedBox(height: 15),

              InkWell(
                onTap: pickDeadline,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: "Deadline",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event),
                  ),
                  child: Text(
                    deadline == null
                        ? "Select Deadline"
                        : "${deadline!.day}/${deadline!.month}/${deadline!.year}",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<ClientModel>(
                value: selectedClient,
                decoration: const InputDecoration(
                  labelText: "Client Name",
                  border: OutlineInputBorder(),
                ),
                items: clients.map((client) {
                  return DropdownMenuItem(
                    value: client,
                    child: Text(client.name ?? "No client added"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedClient = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Please select a client";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: selectedCurrency,
                decoration: const InputDecoration(
                  labelText: "Currency",
                  border: OutlineInputBorder(),
                ),
                items: currencies.map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                decoration: const InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(),
                ),
                items: statuses.map((status) {
                  return DropdownMenuItem(value: status, child: Text(status));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  if (startDate == null || deadline == null) {
                    AppSnackbar.show(
                      context,
                      title: "Date",
                      message: "Please select both dates",
                      type: ContentType.warning,
                    );
                    return;
                  }

                  final project = ProjectModel(
                    id: "",
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    clientId: selectedClient!.id,
                    clientName: selectedClient!.name,
                    projectName: projectNameController.text,
                    description: descriptionController.text,
                    budget: double.parse(budgetController.text),
                    currency: selectedCurrency,
                    status: selectedStatus,
                    startDate: Timestamp.fromDate(startDate!),
                    deadline: Timestamp.fromDate(deadline!),
                    createdAt: Timestamp.now(),
                  );
                  try {
                    await context.read<ProjectProvider>().addProject(project);

                    if (!mounted) return;

                    AppSnackbar.show(
                      context,
                      title: "Success",
                      message: "Project Added Successfully",
                      type: ContentType.success,
                    );

                    Navigator.pop(context);
                  } catch (e) {
                    if (!mounted) return;

                    AppSnackbar.show(
                      context,
                      title: "Error",
                      message: e.toString(),
                      type: ContentType.failure,
                    );
                  }
                },

                child: const Text(
                  "Save Project",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
      initialDate: startDate ?? DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> pickDeadline() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
      initialDate: deadline ?? DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        deadline = picked;
      });
    }
  }
}
