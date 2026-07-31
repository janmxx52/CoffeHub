import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:coffehub/data/models/user_model.dart';
import 'package:coffehub/data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  bool get isLoggedIn => _repository.currentFirebaseUser != null;

  Stream<User?> get authStateChanges => _repository.authStateChanges;


  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> loadCurrentUser() async {
    _setLoading(true);

    try {
      _currentUser = await _repository.getCurrentUser();
      _setError(null);
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
  }

  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    _setLoading(true);

    try {
      _currentUser = await _repository.register(
        email: email,
        password: password,
        fullName: fullName,
      );

      _setError(null);

      _setLoading(false);

      return true;
    } catch (e) {
      _setError(e.toString());

      _setLoading(false);

      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);

    try {
      _currentUser = await _repository.login(
        email: email,
        password: password,
      );

      _setError(null);

      _setLoading(false);

      return true;
    } catch (e) {
      _setError(e.toString());

      _setLoading(false);

      return false;
    }
  }

  Future<void> logout() async {
    _setLoading(true);

    try {
      await _repository.logout();

      _currentUser = null;

      _setError(null);
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
  }


  Future<void> resetPassword(String email) async {
    _setLoading(true);

    try {
      await _repository.resetPassword(email);

      _setError(null);
    } catch (e) {
      _setError(e.toString());
    }

    _setLoading(false);
  }
}
//   /// Kiểm tra người dùng hiện tại
//   void checkCurrentUser() {
//     _currentUser = _repository.currentUser;
//     notifyListeners();
//   }
//
//   /// Đăng nhập
//   Future<bool> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       _setLoading(true);
//       _errorMessage = null;
//
//       final credential = await _repository.login(
//         email: email,
//         password: password,
//       );
//
//       _currentUser = FirebaseAuth.instance.currentUser;
//
//       notifyListeners();
//
//       return true;
//     } on FirebaseAuthException catch (e) {
//       _errorMessage = e.message;
//       notifyListeners();
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   /// Đăng ký
//   Future<bool> register({
//     required String email,
//     required String password,
//     required String fullName,
//   }) async {
//     try {
//       _setLoading(true);
//       _errorMessage = null;
//
//       final user = await _repository.register(
//         email: email,
//         password: password,
//         fullName: fullName,
//       );
//
//       _currentUser = FirebaseAuth.instance.currentUser;
//
//       notifyListeners();
//
//       return true;
//     } on FirebaseAuthException catch (e) {
//       _errorMessage = e.message;
//       notifyListeners();
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   /// Đăng xuất
//   Future<void> logout() async {
//     await _repository.logout();
//
//     _currentUser = null;
//
//     notifyListeners();
//   }
//
//   /// Quên mật khẩu
//   Future<bool> resetPassword(String email) async {
//     try {
//       _setLoading(true);
//
//       await _repository.resetPassword(email: email);
//
//       return true;
//     } on FirebaseAuthException catch (e) {
//       _errorMessage = e.message;
//       notifyListeners();
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }
//
//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
// }