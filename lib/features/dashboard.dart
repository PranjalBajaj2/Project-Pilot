import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/features/auth/providers/payment_provider.dart';
import 'package:projectpilot/routes/route_names.dart';
import 'package:provider/provider.dart';

import '../shared/dashboard_widgets/dashboard_card.dart';
import '../shared/dashboard_widgets/payment_tile.dart';
import '../shared/dashboard_widgets/project_tile.dart';
import '../shared/dashboard_widgets/quick_action_button.dart';
import '../shared/dashboard_widgets/stats_grid.dart';
import 'auth/providers/project_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectProvider>().projects;
    final payments = context.watch<PaymentProvider>().payments;

    final recentProjects = [...projects]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final pendingPayments = payments
        .where((payment) => payment.status.toLowerCase() == "pending")
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const SizedBox(height: 6),

          const Text(
            "Here's what's happening today",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          const StatsGrid(),

          const SizedBox(height: 15),

          const Text(
            "Quick Actions",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              QuickActionButton(
                icon: Icons.person_add,
                title: "Add New Client",
                onTap: () {
                  context.push(RouteNames.addClient);
                },
              ),

              const SizedBox(width: 15),

              QuickActionButton(
                icon: Icons.create_new_folder_rounded,
                title: "Add New Project",
                onTap: () {
                  context.push(RouteNames.addProject);
                },
              ),
              const SizedBox(width: 15),

              QuickActionButton(
                icon: Icons.monetization_on,
                title: "Add New Payment",
                onTap: () {
                  context.push(RouteNames.addPayment);
                },
              ),
            ],
          ),

          const SizedBox(height: 15),

          const Text(
            "Recent Projects",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          DashboardCard(
            child: projects.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: Text("No Projects Yet")),
                  )
                : Column(
                    children: recentProjects
                        .take(2) // Show only the latest 5 projects
                        .map(
                          (project) => RecentProjectTile(
                            title: project.projectName!,
                            client: project.clientName ?? "No Client",
                          ),
                        )
                        .toList(),
                  ),
          ),

          const SizedBox(height: 15),

          const Text(
            "Pending Payments",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          DashboardCard(
            child: pendingPayments.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: Text("No Pending Payments")),
                  )
                : Column(
                    children: pendingPayments
                        .take(5)
                        .map(
                          (payment) => UpcomingPaymentTile(
                            client: payment.clientName ?? "No Client",
                            amount:
                                "${payment.currency} ${payment.amount.toStringAsFixed(0)}",
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
