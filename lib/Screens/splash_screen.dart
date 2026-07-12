import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projectpilot/Screens/login_screen.dart';
import 'package:projectpilot/core/theme/app_colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late Timer _timer;
  bool get isDesktop => MediaQuery.of(context).size.width >= 800;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
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
    return Scaffold(body: isDesktop ? _buildDesktop() : _buildMobile());
  }

  Widget _buildDesktop() {
    return Scaffold(
      backgroundColor: AppColorsLight.primary,
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // IMAGE (center aligned in row)
              Image.asset(
                "images/splash_screen.jpg",
                width: 700,
                // height: 325,
                fit: BoxFit.cover,
              ),

              const SizedBox(width: 5),

              // TEXT COLUMN (right side)
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     AppLogo(size: 46,),
              //     Text("Where freelancers fly forward.",
              //       style: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.w600)
              //)
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
      backgroundColor: AppColorsLight.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // IMAGE (center aligned in row)
              Image.asset(
                "images/mobile_splash.jpg",
                width: width * 0.7,
                //height: height * 0.2,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 20),

              // AppLogo(size: 46,),
              //     Text("Where freelancers fly forward.",
              //       style: GoogleFonts.quicksand(fontSize: 18,fontWeight: FontWeight.w600)
              // )
            ],
          ),
        ),
      ),
    );
  }
}
