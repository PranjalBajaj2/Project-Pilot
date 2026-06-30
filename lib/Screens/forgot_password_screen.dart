import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectpilot/Screens/register_screen.dart';
import 'package:projectpilot/core/utils/validators.dart';
import 'package:projectpilot/shared/widgets/app_logo.dart';
import 'package:projectpilot/shared/widgets/custom_text_field.dart';
import 'package:projectpilot/shared/widgets/primary_button.dart';

import '../routes/app_routes.dart';
import '../routes/route_names.dart';
import '../shared/widgets/auth_card.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordstate();
}

class _ForgotPasswordstate extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool get isDesktop =>
      MediaQuery.of(context).size.width >= 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isDesktop ? _buildDesktop() : _buildMobile(),
    );
  }

  //================ MOBILE =================//

  Widget _buildMobile() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "ProjectPilot",
                  style: GoogleFonts.pinyonScript(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: AuthCard(
                      child: _loginForm(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //================ DESKTOP =================//

  Widget _buildDesktop() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image:
          AssetImage("images/BackPoster.png"),
            fit: BoxFit.fill,)
      ),
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 420,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),

              child: AuthCard(
                child: _loginForm(showTitle: true),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //================ FORM =================//

  Widget _loginForm({bool showTitle = false}) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Forgot Password?",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Enter your email and we'll send you a password reset link.",
          ),

          const SizedBox(height: 40),

          CustomTextField(
            hintText: "Email",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
          ),

          const SizedBox(height: 30),

          PrimaryButton(
            text: "Send Reset Link",
            onPressed: () {
              context.push(RouteNames.login);

            },
          ),

        ],
      ),
    );
  }
}
