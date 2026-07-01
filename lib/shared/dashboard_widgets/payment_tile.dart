import 'package:flutter/material.dart';

class UpcomingPaymentTile extends StatelessWidget {

  final String client;
  final String amount;

  const UpcomingPaymentTile({
    super.key,
    required this.client,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(

      contentPadding: EdgeInsets.zero,

      leading: const Icon(Icons.payments),

      title: Text(client),

      trailing: Text(
        amount,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

    );

  }
}