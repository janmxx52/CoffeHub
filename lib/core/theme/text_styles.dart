import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  /// Splash

  static const splashEyebrow = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 3.2,
    color: AppColors.amber,
  );

  static const splashCoffee = TextStyle(
    fontFamily: 'Fraunces',
    fontSize: 60,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.5,
    height: 0.9,
    color: AppColors.cream,
  );

  static const splashHub = TextStyle(
    fontFamily: 'Fraunces',
    fontSize: 60,
    fontWeight: FontWeight.w600,
    letterSpacing: 3,
    height: 0.9,
    color: AppColors.amber,
  );

  static const splashTagline = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 13,
    fontWeight: FontWeight.w300,
    height: 1.75,
    letterSpacing: 0.4,
    color: AppColors.creamDim,
  );

  static const splashButton = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 2,
    color: AppColors.espresso,
  );

  static const splashSignIn = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 13,
    color: AppColors.amber,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.amber,
  );

  static TextStyle splashMember = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 13,
    color: AppColors.cream.withOpacity(0.38),
  );

  static TextStyle splashBottomLabel = TextStyle(
    fontFamily: 'Outfit',
    fontSize: 9,
    letterSpacing: 2.5,
    color: AppColors.cream.withOpacity(0.25),
  );

  static const TextStyle primaryButton = TextStyle(
    color: AppColors.espresso,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 2,
  );}