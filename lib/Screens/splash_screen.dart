import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projectpilot/Screens/login_screen.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late Timer _timer;
  bool get isDesktop =>
      MediaQuery.of(context).size.width >= 800;

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
      body: isDesktop ? _buildDesktop() : _buildMobile(),
    );
  }



  Widget _buildDesktop() {
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
  Widget _buildMobile() {
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
            ],
          ),
        ),
      ),
    );
  }
}