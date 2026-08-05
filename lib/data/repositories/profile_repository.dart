import '../firebase/profile_service.dart';
import '../models/user_model.dart';

class ProfileRepository {
  final ProfileService _service = ProfileService();

  Future<UserModel?> getCurrentUser() {
    return _service.getCurrentUser();
  }
}