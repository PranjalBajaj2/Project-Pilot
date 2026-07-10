import 'package:flutter/material.dart';

import '../repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();

  bool isLoading = false;

  String? error;

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _repository.register(name: name, email: email, password: password);

      return true;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
      return false;
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _repository.login(email: email, password: password);

      return true;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
    } catch (e) {
      error = e.toString().replaceFirst("Exception: ", "");
    }
  }

  Future<void> forgotPassword(String email) async {
    await _repository.forgotPassword(email);
  }
}
