import 'package:firebase_auth/firebase_auth.dart';

import 'package:coffehub/data/firebase/auth_service.dart';
import 'package:coffehub/data/models/user_model.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  /// Firebase User hiện tại
  User? get currentFirebaseUser => _authService.currentFirebaseUser;

  /// Theo dõi trạng thái đăng nhập
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  /// Đăng ký
  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
  }) {
    return _authService.register(
      email: email,
      password: password,
      fullName: fullName,
    );
  }

  /// Đăng nhập
  Future<UserModel?> login({
    required String email,
    required String password,
  }) {
    return _authService.login(
      email: email,
      password: password,
    );
  }


  /// Đăng xuất
  Future<void> logout() {
    return _authService.logout();
  }

  /// Quên mật khẩu
  Future<void> resetPassword(String email) {
    return _authService.resetPassword(email);
  }

  /// Lấy thông tin người dùng
  Future<UserModel?> getCurrentUser() {
    return _authService.getCurrentUser();
  }
}