import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<UserModel?> loginWithGoogle() {
    return _authService.loginWithGoogle();
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

  Future<void> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String address,
  }) {
    return _authService.updateProfile(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
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
  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!doc.exists) return null;

    return UserModel.fromDocument(doc);
  }
}