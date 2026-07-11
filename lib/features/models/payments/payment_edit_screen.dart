import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/features/auth/models/payment_model.dart';
import 'package:projectpilot/features/auth/models/project_model.dart';
import 'package:projectpilot/features/auth/providers/payment_provider.dart';
import 'package:projectpilot/features/auth/providers/project_provider.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../auth/models/client_model.dart';
import '../../auth/providers/client_provider.dart';

class EditPaymentScreen extends StatefulWidget {
  final PaymentModel payment;

  const EditPaymentScreen({super.key, required this.payment});

  @override
  State<EditPaymentScreen> createState() => _EditPaymentScreenState();
}

class _EditPaymentScreenState extends State<EditPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController amountController;
  late final TextEditingController notesController;
  ProjectModel? selectedProject;
  ClientModel? selectedClient;

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
  void initState() {
    super.initState();

    amountController = TextEditingController(
      text: widget.payment.amount.toString(),
    );

    notesController = TextEditingController(text: widget.payment.notes);

    selectedCurrency = widget.payment.currency;
    selectedStatus = widget.payment.status;
    selectedMethod = widget.payment.paymentMethod;

    paymentDate = widget.payment.paymentDate.toDate();
  }

  @override
  void dispose() {
    amountController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> updatePayment() async {
    if (!_formKey.currentState!.validate()) return;

    if (paymentDate == null) {
      AppSnackbar.show(
        context,
        title: "Date",
        message: "Please select payment dates",
        type: ContentType.warning,
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    final updatedPayments = PaymentModel(
      id: widget.payment.id ?? "",
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
      await context.read<PaymentProvider>().updatePayment(updatedPayments);

      if (!mounted) return;

      AppSnackbar.show(
        context,
        title: "Success",
        message: "Payment Updated Successfully",
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
          (client) => client.id == widget.payment.clientId,
        );
      } catch (_) {
        selectedClient = null;
      }
    }
    final projects = context.watch<ProjectProvider>().projects;
    if (selectedProject == null && projects.isNotEmpty) {
      try {
        selectedProject = projects.firstWhere(
          (project) => project.id == widget.payment.projectId,
        );
      } catch (_) {
        selectedClient = null;
      }
    }
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
                onPressed: isSaving ? null : updatePayment,
                child: isSaving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(),
                      )
                    : const Text(
                        "Update Payment",
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
