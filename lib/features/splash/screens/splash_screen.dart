import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffehub/features/auth/providers/auth_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Center(
        child: Text(
          authProvider.isLoggedIn
              ? 'Đã đăng nhập'
              : 'Chưa đăng nhập',
        ),
      ),
    );
  }
}