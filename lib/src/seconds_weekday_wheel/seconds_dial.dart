import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:clock/src/configuration.dart';
import 'package:clock/src/curved_text_painter.dart';

class SecondsDial extends StatelessWidget {
  final double radius;

  const SecondsDial(this.radius, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> textDial = <Widget>[];
    TextStyle textStyle = GoogleFonts.marvel(
        color: TICKS_COLOR,
        fontSize: radius * 0.08,
        fontWeight: FontWeight.normal);
    const double segment = (2 * pi) / 6;

    for (int i = 1; i <= 6; i++) {
      textDial.add(CustomPaint(
          painter: CurvedTextPainter(
              radius / 2.5, (i * 10).toString(), textStyle,
              initialAngle: i * segment - pi / 45)));
    }

    return AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: textDial,
        ));
  }
}
