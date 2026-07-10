import 'package:flutter/material.dart';

import '../shared/widgets/primary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          PrimaryButton(
            text: "Logout",
            onPressed: (){},
          ),
       const Text(
        "Profile",
        style: TextStyle(fontSize: 28),
       )
        ],
      ),


    );
  }
}