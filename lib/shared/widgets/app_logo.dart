import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    super.key,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "ProjectPilot",
      style: GoogleFonts.pinyonScript(
        fontSize: size,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}