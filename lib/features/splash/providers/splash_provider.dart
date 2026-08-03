import 'package:flutter/cupertino.dart';

import '../../../data/repositories/auth_repository.dart';

class SplashProvider extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<bool> initialize() async {
    await Future.delayed(
      const Duration(seconds: 30),
    );

    final user = await _repository.getCurrentUser();

    _isLoading = false;
    notifyListeners();

    return user != null;
  }
}