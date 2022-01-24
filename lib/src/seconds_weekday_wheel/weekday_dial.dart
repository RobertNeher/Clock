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
    '.',
    'MON',
    '.',
    'TUE',
    '.',
    'WED',
    '.',
    'THU',
    '.',
    'FRI',
    '.',
    'SAT',
    '.'
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> textDial = <Widget>[];
    TextStyle textStyle = GoogleFonts.marvel(
        color: DIGITS_COLOR,
        fontSize: radius * 0.2,
        fontWeight: FontWeight.normal);
    final double segment = (2 * pi) / WEEKDAYS.length;

    for (int i = 0; i < WEEKDAYS.length - 1; i++) {
      textDial.add(CustomPaint(
          painter: WEEKDAYS[i] == '.'
              ? DotPainter()
              : CurvedTextPainter(radius * 0.85, WEEKDAYS[i], textStyle,
                  initialAngle: i * segment)));
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
  @override
  void paint(Canvas canvas, Size size) {
    Paint dotPaint = Paint()
      ..color = DIGITS_COLOR
      ..style = PaintingStyle.stroke;

    canvas.drawPoints(PointMode.points, [Offset(0, 0)], dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
