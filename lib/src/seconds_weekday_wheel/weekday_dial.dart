import 'dart:math';
import 'dart:ui';
import 'package:clock/src/digits_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clock/src/seconds_weekday_wheel/curved_text.dart';
import '../configuration.dart';

class WeekdayDial extends StatelessWidget {
  double radius;

  WeekdayDial(this.radius, {Key? key}) : super(key: key);

  static const List<String> WEEKDAYS = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> textDial = <Widget>[];
    TextStyle textStyle = GoogleFonts.marvel(
        color: DIGITS_COLOR,
        fontSize: radius * 0.2,
        fontWeight: FontWeight.normal);
    final double segment = (2 * pi) / WEEKDAYS.length;
    final double correctionFactor = pi / (2 * WEEKDAYS.length);

    for (int i = 0; i < WEEKDAYS.length; i++) {
      textDial.add(CustomPaint(
          painter: CurvedTextPainter(radius * 0.85, WEEKDAYS[i], textStyle,
              initialAngle: i * segment - correctionFactor)));
      textDial.add(
          CustomPaint(
          painter:
              DotPainter(radius * 0.68, (i + 1) * segment - correctionFactor)));
    }

    return AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: textDial,
        ));
  }
}

class DotPainter extends CustomPainter {
  double radius;
  double angle;
  DotPainter(this.radius, this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    Paint dotPaint = Paint()
      ..color = DIGITS_COLOR
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.rotate(angle);
    canvas.drawPoints(PointMode.points, [Offset(radius, radius)], dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
