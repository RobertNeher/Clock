import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:clock/src/configuration.dart';

const double FONT_SIZE = 12;
const Color DIGITS_COLOR = TICKS_COLOR;
const List<String> DIGITS = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12'
];

class DigitsPainter extends CustomPainter {
  late Color digitsColor;
  TextStyle? digitStyle;

  DigitsPainter({this.digitsColor = TICKS_COLOR});

  @override
  void paint(Canvas canvas, Size size) {
    double radiant;
    Offset digitPosition;
    double radius = size.width / 2;

    digitStyle = GoogleFonts.marvel(
      color: DIGITS_COLOR,
      fontSize: radius / 6,
      fontWeight: FontWeight.bold,
    );

    Paint digitPaint = Paint()..color = digitsColor;
    canvas.translate(radius * 0.97, radius * 0.9);
    radius *= 0.79; // Reduced due to border (see border_paint.dart)
    // and ticks

    for (int i = 1; i <= 12; i++) {
      radiant = (i - 6) * (2 * pi) / 12;
      digitPosition = Offset(-radius * sin(radiant), radius * cos(radiant));

      TextPainter digitPainter = TextPainter(
          text: TextSpan(text: DIGITS[i - 1], style: digitStyle),
          textAlign: TextAlign.justify,
          textDirection: TextDirection.rtl)
        ..layout(maxWidth: 48);
      // canvas.drawPoints(PointMode.points, [digitPosition], digitPaint);
      digitPainter.paint(canvas, digitPosition);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
