import 'package:flutter/material.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import 'package:coffehub/features/auth/screens/register_screen.dart';
class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => const SplashScreen(),
    '/login': (_) => const LoginScreen(),
    '/register': (_) => const RegisterScreen(),
  };
}