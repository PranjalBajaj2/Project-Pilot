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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showTitle) ...[
            Center(
              child: const AppLogo(size: 46,)
            ),
            const SizedBox(height: 40),
          ],

          CustomTextField(
            hintText: "Email",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            validator: Validators.email,
          ),

          const SizedBox(height: 20),

          CustomTextField(
            hintText: "Password",
            controller: passwordController,
            isPassword: true,
            prefixIcon: const Icon(Icons.lock_outline),
            validator: Validators.password,
          ),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.push(RouteNames.forgotPassword);
              },
              child: const Text("Forgot Password?"),
            ),
          ),

          const SizedBox(height: 24),

          PrimaryButton(
            text: "Login",
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              context.go(RouteNames.main);

            },
          ),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  context.push(RouteNames.register);
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
