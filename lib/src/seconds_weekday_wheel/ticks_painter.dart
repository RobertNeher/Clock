import 'dart:math';

import 'package:flutter/material.dart';
import 'package:clock/src/configuration.dart';

class TicksPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double TICK_SIZE_MINUTE = 8;
    const double TICK_SIZE_HOUR = 25;
    const double dialRadiusFactor = 0.85;

    double radius = size.width / 2;
    double radiant;
    Offset start, end;
    double tickSizeMinute = radius / 15;
    double tickSizeHour = radius / 8;

    // canvas.translate(0, 0);

    final Paint tickPaint = Paint()
      ..color = TICKS_COLOR
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    canvas.translate(radius, radius);

    // draw surounding frame for ticks
    canvas.drawCircle(const Offset(0, 0), radius * dialRadiusFactor, tickPaint);
    canvas.drawCircle(
        const Offset(0, 0), radius * dialRadiusFactor - radius / 15, tickPaint);

    for (int i = 1; i <= 60; i++) {
      radiant = i * (2 * pi) / 60;
      start = Offset(radius * dialRadiusFactor * sin(radiant),
          radius * dialRadiusFactor * cos(radiant));

      if (i % 10 == 0) {
        tickPaint.strokeWidth = 10;
        end = Offset(start.dx - tickSizeMinute * sin(radiant),
            start.dy - tickSizeMinute * cos(radiant));
        canvas.drawLine(start, end, tickPaint);
      } else {
        if (i % 5 == 0) {
          tickPaint.strokeWidth = 3;
          end = Offset(start.dx - tickSizeHour * sin(radiant),
              start.dy - tickSizeHour * cos(radiant));
        } else {
          tickPaint.strokeWidth = 2;
          end = Offset(start.dx - tickSizeMinute * sin(radiant),
              start.dy - tickSizeMinute * cos(radiant));
        }
        canvas.drawLine(start, end, tickPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
