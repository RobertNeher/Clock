import 'dart:js';

import 'package:flutter/material.dart';

import 'package:clock/src/configuration.dart';
import 'package:clock/src/border_painter.dart';
import 'package:clock/src/ticks_painter.dart';
import 'package:clock/src/digits_painter.dart';
import 'package:clock/src/hands_paint.dart';

Widget ClockFace(Size size) {
  return AspectRatio(
    aspectRatio: 1.0,
    child: ClipOval(
      clipBehavior: Clip.hardEdge,
      child: Container(
          decoration: const BoxDecoration(
              gradient: RadialGradient(
            colors: [DARK_BLUE, LIGHT_BLUE],
            center: Alignment(0.5, -0.5),
          )),
          child: Stack(alignment: Alignment.center, children: <Widget>[
            CustomPaint(
              painter: BorderPainter(),
              child: Container(),
            ),
            CustomPaint(
              painter: TicksPainter(ticksColor: TICKS_COLOR),
              child: Container(),
            ),
            CustomPaint(
              painter: DigitsPainter(digitsColor: TICKS_COLOR),
              child: Container(),
            ),
            Container(
              height: size.height,
              width: size.width,
              child: HandsPaint(size)
            ),
          ])),
    ),
  );
}
