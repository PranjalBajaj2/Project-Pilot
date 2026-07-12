import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository repository = ProfileRepository();

  UserModel? user;

  bool isLoading = false;

  String? error;

  bool uploadingImage = false;

  Future<void> loadProfile() async {
    try {
      isLoading = true;
      notifyListeners();

      user = await repository.getProfile();

      error = null;
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;

    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {

    final updated = user!.copyWith(
      name: name,
      phone: phone,
    );

    await repository.updateProfile(updated);

    user = updated;

    notifyListeners();
  }
  bool isChangingPassword = false;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isChangingPassword = true;
    notifyListeners();

    try {
      await repository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } finally {
      isChangingPassword = false;
      notifyListeners();
    }
  }
}
