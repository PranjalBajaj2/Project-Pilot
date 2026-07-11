import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:projectpilot/features/auth/models/payment_model.dart';
import 'package:projectpilot/features/auth/models/project_model.dart';
import 'package:projectpilot/features/auth/providers/payment_provider.dart';
import 'package:projectpilot/features/auth/providers/project_provider.dart';
import 'package:projectpilot/shared/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_snackbar.dart';
import '../../auth/models/client_model.dart';
import '../../auth/providers/client_provider.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final notesController = TextEditingController();
  ClientModel? selectedClient;
  ProjectModel? selectedProject;

  String selectedCurrency = "PKR";

  String selectedStatus = "Pending";

  String selectedMethod = "Cash";

  DateTime? paymentDate;

  static const currencies = ["PKR", "USD", "EUR", "GBP"];
  static const statuses = ["Pending", "Received"];
  static const paymentMethods = [
    "Cash",
    "Bank Transfer",
    "JazzCash",
    "EasyPaisa",
    "PayPal",
    "Stripe",
  ];
  bool isLoading = false;
  bool isSaving = false;

  @override
  void dispose() {
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clients = context.watch<ClientProvider>().clients;
    final projects = context.watch<ProjectProvider>().projects;
    return Scaffold(
      appBar: CustomAppBar(title: "Add Payment"),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
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
              DropdownButtonFormField<ProjectModel>(
                value: selectedProject,
                decoration: const InputDecoration(
                  labelText: "Project Name",
                  border: OutlineInputBorder(),
                ),
                items: projects.map((project) {
                  return DropdownMenuItem(
                    value: project,
                    child: Text(project.projectName ?? " "),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProject = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Please select a project";
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
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: "Project Amount",
                  prefixIcon: Icon(Icons.attach_money_rounded),
                ),
                validator: (v) =>
                    v!.isEmpty ? "Project Amount is Required" : null,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: pickPaymentDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: "Payment Date",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event),
                  ),
                  child: Text(
                    paymentDate == null
                        ? "Select Payment Date"
                        : "${paymentDate!.day}/${paymentDate!.month}/${paymentDate!.year}",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedMethod,
                decoration: const InputDecoration(
                  labelText: "Payment Method",
                  border: OutlineInputBorder(),
                ),
                items: paymentMethods.map((payment) {
                  return DropdownMenuItem(value: payment, child: Text(payment));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 10),
              TextFormField(
                controller: notesController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  if (paymentDate == null) {
                    AppSnackbar.show(
                      context,
                      title: "Date",
                      message: "Please select payment date",
                      type: ContentType.warning,
                    );
                    return;
                  }

                  final payment = PaymentModel(
                    id: "",
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    clientId: selectedClient!.id,
                    clientName: selectedClient!.name,
                    projectId: selectedProject!.id,
                    projectName: selectedProject!.projectName,
                    paymentMethod: selectedMethod,
                    status: selectedStatus,
                    notes: notesController.text,
                    currency: selectedCurrency,
                    amount: double.parse(amountController.text),
                    paymentDate: Timestamp.fromDate(paymentDate!),
                    createdAt: Timestamp.now(),
                  );

                  try {
                    await context.read<PaymentProvider>().addPayment(payment);

                    if (!mounted) return;

                    AppSnackbar.show(
                      context,
                      title: "Success",
                      message: "Payment Added Successfully",
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
                  "Save Payment",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickPaymentDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
      initialDate: paymentDate ?? DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        paymentDate = picked;
      });
    }
  }
}
