import 'package:clock/src/year_box.dart';
import 'package:flutter/material.dart';

import 'package:clock/src/configuration.dart';
import 'package:clock/src/border_painter.dart';
import 'package:clock/src/ticks_painter.dart';
import 'package:clock/src/digits_painter.dart';
import 'package:clock/src/hands_paint.dart';

Widget ClockFace(Size size) {
  print(size);
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
            Positioned.fromRect(
              rect: Rect.fromLTWH(size.width * 0.17, size.height * 0.65,
                  size.width / 12, size.height / 26),
              child: YearBox(size),
            ),
            // C,ontainer(
            //   height: size.height,
            //   width: size.width,
            //   child: HandsPaint(size)
            // )
          ])),
    ),
  );
}
