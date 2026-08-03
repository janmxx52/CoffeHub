import 'package:flutter/material.dart';

import 'coffee_cup_painter.dart';

class SteamAnimation extends StatelessWidget {
  final AnimationController controller;

  const SteamAnimation({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          ...List.generate(
            3,
                (index) => _SteamWisp(
              controller: controller,
              index: index,
            ),
          ),

          Positioned(
            bottom: 0,
            child: CustomPaint(
              size: const Size(56, 56),
              painter: CoffeeCupPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SteamWisp extends StatelessWidget {
  final AnimationController controller;
  final int index;

  const _SteamWisp({
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {

    final offsets = [-10.0, 0.0, 10.0];
    final delays = [0.0, 0.25, 0.5];

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {

        final raw =
            (controller.value + delays[index]) % 1.0;

        final t =
        Curves.easeInOut.transform(raw);

        final dy = -60 * t;

        final opacity = t < 0.15
            ? t / 0.15
            : t > 0.75
            ? 1 - (t - 0.75) / 0.25
            : 0.55;

        final scaleX =
            1 + 0.4 * (t < 0.5 ? t * 2 : 1 - (t - 0.5) * 2);

        return Positioned(
          bottom: 58,
          left: MediaQuery.of(context).size.width / 2 -
              16 +
              offsets[index] +
              32,
          child: Opacity(
            opacity: opacity,
            child: Transform.translate(
              offset: Offset(0, dy),
              child: Transform.scale(
                scaleX: scaleX,
                child: Container(
                  width: 3,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0x99C8873A),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}