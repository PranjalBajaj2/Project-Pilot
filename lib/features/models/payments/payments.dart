import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/core/theme/app_colors.dart';
import 'package:projectpilot/features/auth/providers/payment_provider.dart';
import 'package:projectpilot/shared/payment_widgets/payment_card.dart';
import 'package:provider/provider.dart';


import '../../../routes/route_names.dart';

class PaymentsScreen extends StatefulWidget {
  const  PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaymentProvider>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Add new payment",
        hoverColor: AppColors.primary,
        onPressed: () {
          context.push(RouteNames.addPayment);
        },

        child: const Icon(Icons.add_box),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: searchController,

              onChanged: provider.searchPayment,

              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),

                hintText: "Search Payment",
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

                  if (provider.payments.isEmpty) {
                    return const Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.payments_outlined,size: 100,),
                        Text("No Payments Found",style: TextStyle(fontSize: 25),)
                      ],
                    ));
                  }

                  return ListView.builder(
                    itemCount: provider.payments.length,
                    itemBuilder: (context, index) {
                      final payment = provider.payments[index];

                      return PaymentTile(
                          payment: payment,
                          onEdit: () {
                            context.push('/edit-payment', extra: payment);
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
