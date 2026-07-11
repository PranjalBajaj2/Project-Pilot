import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectpilot/core/utils/validators.dart';
import 'package:projectpilot/shared/widgets/custom_text_field.dart';
import 'package:projectpilot/shared/widgets/primary_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:provider/provider.dart';

import '../features/auth/providers/auth_provider.dart';
import '../routes/route_names.dart';
import '../shared/widgets/app_snackbar.dart';
import '../shared/widgets/auth_layout.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Account",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              "Start managing your freelance business today.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 40),

            CustomTextField(
              hintText: "Full Name",
              controller: nameController,
              prefixIcon: const Icon(Icons.person_outline),
            ),

            const SizedBox(height: 20),

            CustomTextField(
              hintText: "Email",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined),
              validator: Validators.email,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              validator: Validators.password,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              // validator: Validators.confirmPassword,
            ),

            const SizedBox(height: 32),

            PrimaryButton(
              text: "Create Account",
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;

                final authProvider = context.read<AuthProvider>();

                final success = await authProvider.register(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );

                if (!mounted) return;

                if (success) {
                  AppSnackbar.show(
                    context,
                    title: "Congratulations",
                    message: "you can login now",
                    type: ContentType.success,
                  );
                  context.go(RouteNames.login);
                } else {
                  AppSnackbar.show(
                    context,
                    title: "Registration failed",
                    message: authProvider.error ?? "Something went wrong",
                    type: ContentType.failure,
                  );
                }
              },
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),

                TextButton(
                  onPressed: () {
                    context.push(RouteNames.login);
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
