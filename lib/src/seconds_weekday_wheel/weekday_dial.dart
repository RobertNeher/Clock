import 'dart:math';
import 'dart:ui';
import 'package:clock/src/digits_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clock/src/curved_text_painter.dart';

class WeekdayDial extends StatelessWidget {
  Size size = Size.zero;

  WeekdayDial(this.size, {Key? key}) : super(key: key);

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
    final TextStyle textStyleSeconds = GoogleFonts.marvel(
        color: DIGITS_COLOR,
        fontSize: (size.width / 2) * 0.02,
        fontWeight: FontWeight.normal);
    final double segment = (2 * pi) / WEEKDAYS.length;

    for (int i = 0; i < WEEKDAYS.length; i++) {
      textDial.add(CustomPaint(
          painter: CurvedTextPainter(0, WEEKDAYS[i], textStyleSeconds,
              initialAngle: i * segment)));
      textDial.add(CustomPaint(painter: DotPainter((i + 1) * segment, size)));
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
  final Size dialSize;
  final double angle;
  DotPainter(this.angle, this.dialSize);

  @override
  void paint(Canvas canvas, Size size) {
    Paint dotPaint = Paint()
      ..color = DIGITS_COLOR
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.rotate(angle + pi / 4);
    canvas.drawPoints(PointMode.points,
        [Offset(dialSize.width / 3.8, dialSize.height / 3.8)], dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
