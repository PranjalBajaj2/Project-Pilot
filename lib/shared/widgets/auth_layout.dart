import 'package:flutter/material.dart';
import 'package:projectpilot/shared/widgets/app_logo.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 768) {
      return Scaffold(
        body: Row(
          children: [
            /// Left Side
            Expanded(
              flex: 5,
              child: Container(
                //color: const Color(0xFFE18D5D),
                decoration: BoxDecoration(
                  color: const Color(0xFFE18D5D),
                  //   image: DecorationImage(
                  //       image: AssetImage("images/splash.png"))
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.laptop_mac_outlined,
                        //color: Colors.white,
                        size: 90,
                      ),
                      SizedBox(height: 20),
                      AppLogo(size: 46),
                      SizedBox(height: 10),
                      Text(
                        "Manage Clients.\nTrack Projects.\nGrow Faster.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          //color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Right Side
            Expanded(
              flex: 4,
              child: Center(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 420,
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}
