import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/providers/client_provider.dart';
import '../../features/auth/providers/payment_provider.dart';
import '../../features/auth/providers/project_provider.dart';
import 'dashboard_card.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = context.watch<ClientProvider>().clients;
    final projects = context.watch<ProjectProvider>().projects;
    final payments = context.watch<PaymentProvider>().payments;

    final totalClients = clients.length;

    final totalProjects = projects.length;

    final totalRevenue = payments
        .where((payment) => payment.status == "Received")
        .fold<double>(0, (sum, payment) => sum + payment.amount);
    final pendingRevenue = payments
        .where((payment) => payment.status == "Pending")
        .fold<double>(0, (sum, payment) => sum + payment.amount);

    return GridView.count(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,

      crossAxisSpacing: 16,

      mainAxisSpacing: 16,

      childAspectRatio: 1.5,

      children: [
        _StatCard(
          title: "Received Amount",
          value: totalRevenue.toStringAsFixed(0),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),

        _StatCard(
          title: "Total Projects",
          value: totalProjects.toString(),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),

        _StatCard(
          title: "Total Clients",
          value: totalClients.toString(),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),

        _StatCard(
          title: "Pending Payments",
          value: pendingRevenue.toStringAsFixed(0),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(
            value,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(title),
        ],
      ),
    );
  }
}
