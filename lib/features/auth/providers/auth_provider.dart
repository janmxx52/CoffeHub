import 'package:cloud_firestore/cloud_firestore.dart';
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
        case 'wrong-password':
          _errorMessage = 'Email hoặc mật khẩu không đúng';
          break;

        case 'user-not-found':
          _errorMessage = 'Tài khoản không tồn tại';
          break;

        case 'too-many-requests':
          _errorMessage =
          'Bạn đã nhập sai quá nhiều lần. Vui lòng thử lại sau.';
          break;

        case 'network-request-failed':
          _errorMessage =
          'Không có kết nối Internet.';
          break;

        default:
          _errorMessage = 'Đăng nhập thất bại. Vui lòng thử lại.';
      }

      return false;
    } catch (_) {
      _errorMessage = 'Có lỗi xảy ra. Vui lòng thử lại.';
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
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          _errorMessage = 'Email đã được sử dụng';
          break;

        case 'network-request-failed':
          _errorMessage = 'Không có kết nối Internet';
          break;

        default:
          _errorMessage =
              e.message ?? 'Đăng ký thất bại. Vui lòng thử lại.';
      }

      return false;
    } catch (e) {
      _errorMessage = 'Đã xảy ra lỗi. Vui lòng thử lại.';
      debugPrint('Register Error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await _repository.updateProfile(
        fullName: fullName,
        phoneNumber: phoneNumber,
        address: address,
      );

      if (_currentUser != null) {
        _currentUser = _currentUser!.copyWith(
          fullName: fullName,
          phoneNumber: phoneNumber,
          address: address,
          updatedAt: Timestamp.now(),
        );
      }

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

  Future<bool> loginWithGoogle() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = await _repository.loginWithGoogle();

      if (user == null) {
        return false;
      }

      _currentUser = user;

      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<bool> loginWithFacebook() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = await _repository.loginWithFacebook();

      if (user == null) {
        return false;
      }

      _currentUser = user;

      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<bool> loginWithApple() async {
  //   try {
  //     _isLoading = true;
  //     _errorMessage = null;
  //     notifyListeners();
  //
  //     final user = await _repository.loginWithApple();
  //
  //     if (user == null) return false;
  //
  //     _currentUser = user;
  //
  //     return true;
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     return false;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}