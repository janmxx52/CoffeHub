import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class SplashBackground extends StatelessWidget {
  final Animation<double> animation;

  const SplashBackground({
    super.key,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [

        FadeTransition(
          opacity: animation,
          child: Image.network(
            'https://images.unsplash.com/photo-1620820186187-fc32e79adb74'
                '?w=800&h=1400&fit=crop&auto=format',
            fit: BoxFit.cover,
            color: AppColors.espresso.withOpacity(0.78),
            colorBlendMode: BlendMode.multiply,
          ),
        ),

        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, 0.3),
              radius: 0.9,
              colors: [
                Color(0x33C8873A),
                Colors.transparent,
              ],
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.espresso,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}