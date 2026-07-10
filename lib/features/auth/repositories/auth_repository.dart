import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _service = AuthService();

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _service.register(name: name, email: email, password: password);
  }

  Future<void> login({required String email, required String password}) {
    return _service.login(email: email, password: password);
  }

  Future<void> logout() {
    return _service.logout();
  }

  Future<void> forgotPassword(String email) {
    return _service.forgotPassword(email);
  }
}
