import 'package:flutter/material.dart';

import 'package:clock/src/configuration.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(Offset(radius, radius), radius, paint);
    paint.color = Colors.white;
    canvas.drawCircle(Offset(radius, radius), radius * 0.98, paint);
    paint.color = const Color(0xFF9C9C9C);
    canvas.drawCircle(Offset(radius, radius), radius * 0.96, paint);
    paint.color = DARK_BLUE;
    paint.strokeWidth = radius * 0.02;
    canvas.drawCircle(Offset(radius, radius), radius * 0.94, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
