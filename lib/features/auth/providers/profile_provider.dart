import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository repository = ProfileRepository();

  UserModel? user;

  bool isLoading = false;

  String? error;

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

  Future<void> updateProfile(UserModel updatedUser) async {
    await repository.updateProfile(updatedUser);

    user = updatedUser;

    notifyListeners();
  }
}
