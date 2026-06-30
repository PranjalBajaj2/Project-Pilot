import 'package:flutter/material.dart';
import 'package:projectpilot/Screens/Splash/SplashScreen.dart';
import 'package:projectpilot/Screens/Splash/Splash_Mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';


class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SplashMobile(),
      desktop: const Splashscreen(),

    );
  }
}