import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(icon,size:30),

              const SizedBox(height:10),

              Text(title),

            ],
          ),
        ),
      ),
    );

  }
}
//
// import 'package:flutter/material.dart';
// class QuickActionButton extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//
//   const QuickActionButton({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             heroTag: title, // Make sure each FAB has a unique heroTag
//             onPressed: onTap,
//             child: Icon(icon),
//           ),
//           const SizedBox(height: 8),
//           Text(title),
//         ],
//       ),
//     );
//   }
