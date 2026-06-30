import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login_screen.dart';

class SplashMobile extends StatefulWidget {
  const SplashMobile({super.key});

  @override
  State<SplashMobile> createState() => _SplashMobileState();
}

class _SplashMobileState extends State<SplashMobile> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFE18D5D),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // IMAGE (center aligned in row)
              Image.asset(
                "images/splash.png",
                width: width * 0.5,
                height: height * 0.2,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 20),

              Image.asset(
                "images/logo.jpg",
                width: 400,
                height: 250,
                fit: BoxFit.cover,
              ),
          // Text(
          //   "ProjectPilot",
          //   style: GoogleFonts.pinyonScript(
          //       fontSize: 38,
          //       fontWeight: FontWeight.w700
          //   ),
          // ),
          // const SizedBox(height: 8),
          // Text(
          //     "Where freelancers fly forward.",
          //     style: GoogleFonts.quicksand(
          //         fontSize: 20,
          //         fontWeight: FontWeight.w400
          //     )
          // ),

              // TEXT COLUMN (right side)
          //     Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //
          //       ],
          //     ),
          //   ],
          // ),
          ],
        ),
      ),
      ),
    );
  }
}
