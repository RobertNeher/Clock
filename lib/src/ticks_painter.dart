import 'dart:math';

import 'package:flutter/material.dart';

import 'package:clock/src/configuration.dart';

const double TICK_SIZE_MINUTE = 10;
const double TICK_SIZE_HOUR = 13;

class TicksPainter extends CustomPainter {
  Color ticksColor;
  TicksPainter({this.ticksColor = TICKS_COLOR});

  @override
  void paint(Canvas canvas, Size size) {
    double radiant;
    Offset start, end;
    double radius = size.width / 2;
    double tickSizeMinute = radius / 40;
    double tickSizeHour = radius / 37;

    Paint tickPaint = Paint()
      ..color = ticksColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    canvas.translate(radius, radius);
    radius *= 0.9; // Reduced due to border (see border_paint.dart)

    // draw surounding frame for ticks
    canvas.drawCircle(const Offset(0, 0), radius * 1.007, tickPaint);
    canvas.drawCircle(const Offset(0, 0), radius - radius / 35, tickPaint);

    for (int i = 1; i <= 60; i++) {
      radiant = i * (2 * pi) / 60;
      start = Offset(radius * sin(radiant), radius * cos(radiant));

      if (i % 5 == 0) {
        tickPaint.strokeWidth = 8;
        end = Offset(start.dx - tickSizeHour * sin(radiant),
            start.dy - tickSizeHour * cos(radiant));
      } else {
        tickPaint.strokeWidth = 3;
        end = Offset(start.dx - tickSizeMinute * sin(radiant),
            start.dy - tickSizeMinute * cos(radiant));
      }
      canvas.drawLine(start, end, tickPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
