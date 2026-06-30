import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectpilot/Screens/login_screen.dart';
import 'package:projectpilot/features/dashboard.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 3), () {
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
    return Scaffold(
      backgroundColor: Color(0xFFE18D5D),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // IMAGE (center aligned in row)
              Image.asset(
                "images/splash.png",
                width: 300,
                height: 325,
                fit: BoxFit.cover,
              ),

              const SizedBox(width: 5),

              // TEXT COLUMN (right side)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/logo.jpg",
                    width: 400,
                    height: 250,
                    fit: BoxFit.cover,
                  ),],
              ),
            ],
          ),

        ),
      ),
    );
  }
}