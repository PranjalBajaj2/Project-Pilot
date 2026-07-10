import '../models/user_model.dart';
import '../services/profile_service.dart';

class ProfileRepository {
  final ProfileService service = ProfileService();

  Future<UserModel> getProfile() {
    return service.getProfile();
  }

  Future<void> updateProfile(UserModel user) {
    return service.updateProfile(user);
  }
}
