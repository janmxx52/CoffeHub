import 'package:flutter/material.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();


  bool _isLoading = false;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  UserModel? _currentUser;

  bool get isLoading => _isLoading;

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  bool get isAdmin => _currentUser?.role == 'admin';

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = await _repository.login(
        email: email,
        password: password,
      );

      _currentUser = user;

      return user != null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          _errorMessage = 'Email hoặc mật khẩu không đúng';
          break;
        case 'user-not-found':
          _errorMessage = 'Không tìm thấy tài khoản';
          break;
        case 'wrong-password':
          _errorMessage = 'Sai mật khẩu';
          break;
        default:
          _errorMessage = e.message ?? 'Đăng nhập thất bại';
      }
      return false;
    } catch (e) {
      _errorMessage = 'Đăng nhập thất bại. Vui lòng thử lại.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = await _repository.register(
        fullName: fullName,
        email: email,
        password: password,
      );

      _currentUser = user;

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _repository.logout();

    _currentUser = null;

    notifyListeners();
  }
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
  Future<void> loadCurrentUser() async {
    _currentUser = await _repository.getCurrentUser();

    notifyListeners();
  }
}