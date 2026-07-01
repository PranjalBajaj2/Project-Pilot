import 'package:flutter/material.dart';
import 'dashboard_card.dart';

class StatsGrid extends StatelessWidget {

  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {

    return GridView.count(

      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      crossAxisCount:
      MediaQuery.of(context).size.width>900?4:2,

      crossAxisSpacing: 16,

      mainAxisSpacing: 16,

      childAspectRatio: 1.5,

      children: [


        _StatCard(
          title:"Revenue",
          value:"\$12,450",
          color: Theme.of(context).colorScheme.primaryContainer,
        ),

        _StatCard(
          title:"Projects",
          value:"8",
          color: Theme.of(context).colorScheme.primaryContainer,
        ),

         _StatCard(
          title:"Clients",
          value:"15",
          color: Theme.of(context).colorScheme.primaryContainer,
        ),

         _StatCard(
          title:"Pending",
          value:"\$2,300",
           color: Theme.of(context).colorScheme.primaryContainer,
        ),

      ],
    );

  }
}

class _StatCard extends StatelessWidget{

  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context){

    return DashboardCard(
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Text(
            value,
            style:  TextStyle(
              fontSize:26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height:8),

          Text(title),

        ],

      ),
    );

  }

}