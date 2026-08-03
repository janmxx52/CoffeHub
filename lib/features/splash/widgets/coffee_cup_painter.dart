import 'package:flutter/material.dart';

class CoffeeCupPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC8873A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width / 64;

    final body = Path()
      ..moveTo(10 * s, 22 * s)
      ..lineTo(46 * s, 22 * s)
      ..lineTo(42 * s, 48 * s)
      ..lineTo(14 * s, 48 * s)
      ..close();

    canvas.drawPath(body, paint);

    final handle = Path()
      ..moveTo(46 * s, 28 * s)
      ..cubicTo(52 * s, 28 * s, 55 * s, 31 * s, 55 * s, 35 * s)
      ..cubicTo(55 * s, 39 * s, 52 * s, 42 * s, 46 * s, 42 * s);

    canvas.drawPath(handle, paint);

    canvas.drawLine(
      Offset(6 * s, 50 * s),
      Offset(50 * s, 50 * s),
      paint,
    );

    canvas.drawLine(
      Offset(14 * s, 28 * s),
      Offset(42 * s, 28 * s),
      paint..color = const Color(0x66C8873A),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}