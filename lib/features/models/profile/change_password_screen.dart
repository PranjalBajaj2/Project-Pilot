import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../auth/providers/profile_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();

  final newPasswordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool isSaving = false;

  Future<void> changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isSaving = true;
    });

    try {
      final provider = context.read<ProfileProvider>();

      await provider.changePassword(
        currentPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      );
      if (!context.mounted) return;

      AppSnackbar.show(
        context,
        title: "Success",
        message: "Password Updated Successfully",
        type: ContentType.success,
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      AppSnackbar.show(
        context,
        title: "Error",
        message: e.toString(),
        type: ContentType.failure,
      );
    }

    if (mounted) {
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ThemeProvider>();
    return Scaffold(
      backgroundColor: provider.isDark
          ? AppColorsDark.secondary
          : AppColorsLight.surface,
      appBar: CustomAppBar(title: "Change Password"),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              TextFormField(
                controller: currentPasswordController,
                decoration: const InputDecoration(
                  labelText: "Current Password",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: newPasswordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(labelText: "New Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required";
                  }

                  if (value.length < 6) {
                    return "Minimum 6 characters";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                ),
                validator: (value) {
                  if (value != newPasswordController.text) {
                    return "Passwords don't match";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: isSaving ? null : changePassword,
                child: isSaving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(),
                      )
                    : const Text(
                        "Update Password",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
