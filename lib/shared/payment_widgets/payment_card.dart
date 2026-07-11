import 'package:flutter/material.dart';
import 'package:projectpilot/core/theme/app_colors.dart';
import 'package:projectpilot/features/auth/models/payment_model.dart';
import 'package:projectpilot/features/auth/providers/payment_provider.dart';

import 'package:provider/provider.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../widgets/app_snackbar.dart';

class PaymentTile extends StatefulWidget {
  final PaymentModel payment;
  final VoidCallback onEdit;

  const PaymentTile({super.key, required this.payment, required this.onEdit});

  @override
  State<PaymentTile> createState() => _PaymentTileState();
}

class _PaymentTileState extends State<PaymentTile> {
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
    final provider = Provider.of<PaymentProvider>(context, listen: false);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Payment"),
          content: const Text("Are you sure you want to delete this Payment?"),
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
      await provider.deletePayment(widget.payment.id);

      if (mounted) {
        AppSnackbar.show(
          context,
          title: "Payment",
          message: "Deleted Successfully",
          type: ContentType.success,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final payment = widget.payment;

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
                  CircleAvatar(
                    child: Text(
                      payment.projectName != null &&
                              payment.projectName!.isNotEmpty
                          ? payment.projectName![0].toUpperCase()
                          : "?",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value(payment.projectName?.toUpperCase()),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          value(payment.clientName),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),

                  buildRow("Project Name:", payment.projectName),

                  buildRow("Client Name:", payment.clientName),

                  buildRow(
                    "Project Amount:",
                    "${payment.currency} ${payment.amount.toStringAsFixed(0)}",
                  ),
                  buildRow(
                    "Payment Date:",
                    "${payment.paymentDate.toDate().day}/${payment.paymentDate.toDate().month}/${payment.paymentDate.toDate().year}",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 150,
                          child: Text(
                            "Payment Method:",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        paymentChip(payment.paymentMethod),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 150,
                          child: Text(
                            "Payment Status:",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        statusChip(payment.status),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

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

Widget statusChip(String status) {
  Color color;

  switch (status.toLowerCase()) {
    case "received":
      color = AppColors.success;
      break;

    case "pending":
      color = AppColors.error;
      break;

    default:
      color = Colors.orange;
  }

  return Chip(
    backgroundColor: color.withOpacity(0.15),
    side: BorderSide.none,
    label: Text(
      status,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    ),
  );
}

Widget paymentChip(String paymentMethod) {
  //Icon icon;
  Color color;

  switch (paymentMethod.toLowerCase()) {
    case "Cash":
      color = Colors.white54;

    case "JazzCash":
      color = AppColors.error;
      break;

    case "EasyPaisa":
      color = AppColors.success;
      break;

    case "Bank Transfer":
      color = Colors.blue;
      break;

    case "PayPal":
      color = Color(0xFF0B112E);
      break;

    case "Stripe":
      color = Color(0xFF184885);
      break;

    default:
      color = Colors.orange;
  }

  return Chip(
    backgroundColor: color.withOpacity(0.15),
    side: BorderSide.none,
    label: Text(
      paymentMethod,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    ),
  );
}
