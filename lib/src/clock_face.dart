import 'dart:ui';

import 'package:clock/src/seconds_weekday_wheel/seconds_weekday_wheel.dart';
import 'package:clock/src/year_box.dart';
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
            // The frame, case of the watch, usually kept with straps on your arm...
            CustomPaint(
              painter: BorderPainter(),
              child: Container(),
            ),
            // Draw ticks frame
            CustomPaint(
              painter: TicksPainter(ticksColor: TICKS_COLOR),
              child: Container(),
            ),
            // Draw the digit themselves. Font does not match. it is close to my opinion
            // Original font is property of IWC
            CustomPaint(
              painter: DigitsPainter(digitsColor: TICKS_COLOR),
              child: Container(),
            ),
            // Year Box at 8 o'clock
            Positioned.fromRect(
              rect: Rect.fromLTWH(size.width * 0.17, size.height * 0.65,
                  size.width / 12, size.height / 26),
              child: YearBox(size),
            ),
            // Seconds Weekday Wheel
            Positioned.fromRect(
              rect: Rect.fromLTWH(size.width * 0.07, size.height / 3.3,
                  size.width / 3.5, size.height / 3.5),
              // child: Container(color: const Color.fromARGB(128, 145, 161, 173)),
              child: SecondsWeekDayWheel(size),
            ),
            // Moon and Stars Wheel
            Positioned.fromRect(
              rect: Rect.fromLTWH(size.width * 0.2, size.height * 0.1,
                  size.width / 3.5, size.height / 3.5),
              child: Container(color: const Color.fromARGB(128, 128, 160, 145)),
            ),
            // Month day Power Reserve Wheel
            Positioned.fromRect(
              rect: Rect.fromLTWH(size.width * 0.49, size.height / 3.5,
                  size.width / 3.5, size.height / 3.5),
              child: Container(color: const Color.fromARGB(55, 172, 109, 161)),
            ),
            // Month and logo wheel
            Positioned.fromRect(
              rect: Rect.fromLTWH(size.width * 0.285, size.height * 0.6,
                  size.width / 3.5, size.height / 3.5),
              child: Container(color: const Color.fromARGB(55, 184, 58, 58)),
            ),
            Container(
                height: size.height,
                width: size.width,
                child: HandsPaint(size)),
          ])),
    ),
  );
}
