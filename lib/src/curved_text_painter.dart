import 'dart:math';
import 'package:flutter/material.dart';

class CurvedTextPainter extends CustomPainter {
  CurvedTextPainter(this.radius, this.text, this.textStyle,
      {this.initialAngle = 0});

  final double radius;
  final String text;
  final double initialAngle;
  final TextStyle textStyle;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    print(radius);
    canvas.translate(radius * 1.8, radius * 0.8);

    if (initialAngle != 0) {
      final d = 2 * radius * sin(initialAngle / 2);
      final rotationAngle = _calculateRotationAngle(0, initialAngle);
      canvas.rotate(rotationAngle);
      canvas.translate(d, 0);
    }

    double angle = initialAngle;
    for (int i = 0; i < text.length; i++) {
      angle = _drawLetter(canvas, text[i], size, angle);
    }
  }

  double _drawLetter(
      Canvas canvas, String letter, Size size, double prevAngle) {
    _textPainter.text = TextSpan(text: letter, style: textStyle);
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    final double d = _textPainter.width;
    final double alpha = 2 * asin(d / (size.width));

    final newAngle = _calculateRotationAngle(prevAngle, alpha);
    canvas.rotate(newAngle);

    _textPainter.paint(canvas, Offset(0, -size.height * 0.1));
    canvas.translate(d, 0);

    return alpha;
  }

  double _calculateRotationAngle(double prevAngle, double alpha) =>
      (alpha + prevAngle) / 2;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
