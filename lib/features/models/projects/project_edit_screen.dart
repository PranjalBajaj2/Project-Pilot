import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/features/auth/models/project_model.dart';
import 'package:projectpilot/features/auth/providers/project_provider.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../auth/models/client_model.dart';
import '../../auth/providers/client_provider.dart';

class EditProjectScreen extends StatefulWidget {
  final ProjectModel project;

  const EditProjectScreen({super.key, required this.project});

  @override
  State<EditProjectScreen> createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController projectNameController;
  late final TextEditingController descriptionController;
  late final TextEditingController budgetController;
  ClientModel? selectedClient;

  String selectedCurrency = "PKR";

  String selectedStatus = "Pending";

  DateTime? startDate;
  DateTime? deadline;

  static const currencies = ["PKR", "USD", "EUR", "GBP"];
  static const statuses = ["Pending", "In Progress", "Completed", "Cancelled"];
  bool isLoading = false;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    projectNameController = TextEditingController(text: widget.project.projectName);;

    descriptionController = TextEditingController(text: widget.project.description);;

    budgetController = TextEditingController(text: widget.project.budget.toString());

    selectedCurrency = widget.project.currency;
    selectedStatus = widget.project.status;

    startDate = widget.project.startDate.toDate();
    deadline = widget.project.deadline.toDate();
  }


  @override
  void dispose() {
    projectNameController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  Future<void> updateProject() async {
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

    setState(() {
      isSaving = true;
    });

    final updatedProject = ProjectModel(
      id: widget.project.id ?? "",
      userId: FirebaseAuth.instance.currentUser!.uid,
      clientId: selectedClient!.id,
      clientName: selectedClient!.name,
      projectName: projectNameController.text.trim(),
      description: descriptionController.text.trim(),
      budget: double.parse(budgetController.text),
      currency: selectedCurrency,
      status: selectedStatus,
      startDate: Timestamp.fromDate(startDate!),
      deadline: Timestamp.fromDate(deadline!),
      createdAt: widget.project.createdAt ?? Timestamp.now(),
    );

    try {
      await context.read<ProjectProvider>().updateProject(updatedProject);

      if (!mounted) return;

      AppSnackbar.show(
        context,
        title: "Success",
        message: "Project Updated Successfully",
        type: ContentType.success,
      );


      context.pop();
    } catch (e) {
      if (!mounted) return;

      AppSnackbar.show(
        context,
        title: "Error",
        message: e.toString(),
        type: ContentType.failure,
      );
    }

    if (mounted) {
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final clients = context.watch<ClientProvider>().clients;
    if (selectedClient == null && clients.isNotEmpty) {
      try {
        selectedClient = clients.firstWhere(
              (client) => client.id == widget.project.clientId,
        );
      } catch (_) {
        selectedClient = null;
      }
    }
    return Scaffold(
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
                onPressed: isSaving ? null : updateProject,
                child: isSaving
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(),
                )
                    : const Text("Update Project",
                style: TextStyle(fontSize: 18),),
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
