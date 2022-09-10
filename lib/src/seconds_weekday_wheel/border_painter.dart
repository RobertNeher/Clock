import 'package:flutter/material.dart';

import 'package:clock/src/configuration.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Size center = size / 2;
    Paint paint = Paint()
      ..color = DARK_BLUE
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
        Offset(center.width, center.height), center.height * 0.95, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
