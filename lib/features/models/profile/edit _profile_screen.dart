import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:projectpilot/features/auth/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../shared/widgets/app_snackbar.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../auth/providers/profile_provider.dart';


class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;

  bool isLoading = false;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    final user =
    context
        .read<ProfileProvider>()
        .user!;

    nameController =
        TextEditingController(text: user.name);

    phoneController =
        TextEditingController(text: user.phone);
  }


  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> updatePayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isSaving = true;
    });

    try {
      final provider = context.read<ProfileProvider>();

      await provider.updateProfile(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
      );

      if (!context.mounted) return;

      AppSnackbar.show(
        context,
        title: "Success",
        message: "Profile Updated Successfully",
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
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      backgroundColor: themeProvider.isDark
          ? AppColorsDark.secondary
          : AppColorsLight.surface,
      appBar: CustomAppBar(title: "Edit Profile"),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: isSaving ? null : updatePayment,
                child: isSaving
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(),
                )
                    : const Text("Save",
                  style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}