import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:clock/src/configuration.dart';

const double HANDS_WIDTH = 7;

class HandsPaint extends StatefulWidget {
  Size size;
  HandsPaint(this.size, {Key? key}) : super(key: key);

  @override
  _HandsPaintState createState() => _HandsPaintState();
}

class _HandsPaintState extends State<HandsPaint> {
  late DateTime actualDateTime;
  late Timer heartBeat;
  int hour = 0;
  int minute = 0;

  @override
  void initState() {
    hour = 0;
    minute = 0;
    heartBeat = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      actualDateTime = DateTime.now();

      minute++;

      if (minute > 60) {
        minute = 1;
        hour++;

        if (hour > 12) {
          hour = 1;
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    actualDateTime = DateTime.now();
    super.setState(fn);
  }

  @override
  void dispose() {
    heartBeat.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: HandsPainter(
            hour: hour, // actualDateTime.hour,
            minute: minute, // actualDateTime.minute,
            handsColor: TICKS_COLOR,
            size: widget.size),
      ),
    );
  }
}

class HandsPainter extends CustomPainter {
  int hour;
  int minute;
  Color handsColor = TICKS_COLOR;
  Size size;

  HandsPainter(
      {required this.hour,
      required this.minute,
      required this.handsColor,
      this.size = Size.zero});

  @override
  void paint(Canvas canvas, Size _size) {
    final double radius = size.width / 2;
    final double hourHandLength = radius * 0.7;
    final double minuteHandLength = hourHandLength * 0.7;
    const double hourFactor = (2 * pi) / 12;
    const double minuteFactor = (2 * pi) / 60;
    double hourRadiant = 0;
    double minuteRadiant = 0;
    double smoothHour = (minute / 60) * (5 * (2 * pi) / 60);

    if (hour <= 12) {
      hourRadiant = hour * hourFactor;
    } else {
      hourRadiant = (hour - 12) * hourFactor;
    }
    hourRadiant += smoothHour;
    minuteRadiant = minute * minuteFactor;

    Float64List hourTransform = Float64List.fromList([
      cos((hourRadiant - 3 * hourFactor)),
      sin((hourRadiant - 3 * hourFactor)),
      0,
      0,
      -sin((hourRadiant - 3 * hourFactor)),
      cos((hourRadiant - 3 * hourFactor)),
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1
    ]);
    Float64List minuteTransform = Float64List.fromList([
      cos(minuteRadiant - 15 * minuteFactor),
      sin(minuteRadiant - 15 * minuteFactor),
      0,
      0,
      -sin(minuteRadiant - 15 * minuteFactor),
      cos(minuteRadiant - 15 * minuteFactor),
      1,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1
    ]);

    Paint handsPaint = Paint()
      ..color = handsColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    // canvas.translate(radius, radius);

    Path hourHand = Path();
    hourHand.moveTo(-HANDS_WIDTH / 2, 0);
    hourHand.relativeLineTo(hourHandLength / 2, HANDS_WIDTH);
    hourHand.relativeLineTo(hourHandLength / 2, -HANDS_WIDTH);
    hourHand.relativeLineTo(-hourHandLength / 2, -HANDS_WIDTH);
    hourHand.relativeLineTo(-hourHandLength / 2, HANDS_WIDTH);

    Path minuteHand = Path();
    minuteHand.moveTo(-HANDS_WIDTH / 2, 0);
    minuteHand.relativeLineTo(minuteHandLength / 2, HANDS_WIDTH);
    minuteHand.relativeLineTo(minuteHandLength / 2, -HANDS_WIDTH);
    minuteHand.relativeLineTo(-minuteHandLength / 2, -HANDS_WIDTH);
    minuteHand.relativeLineTo(-minuteHandLength / 2, HANDS_WIDTH);

    handsPaint.color = TICKS_COLOR;
    canvas.drawCircle(Offset.zero, HANDS_WIDTH * 1.5, handsPaint);
    canvas.drawPath(minuteHand.transform(hourTransform), handsPaint);
    canvas.drawShadow(
        minuteHand.transform(hourTransform), DARK_BLUE, HANDS_WIDTH / 2, true);

    canvas.drawCircle(Offset.zero, HANDS_WIDTH, handsPaint);

    canvas.drawPath(hourHand.transform(minuteTransform), handsPaint);
    canvas.drawShadow(
        hourHand.transform(minuteTransform), DARK_BLUE, HANDS_WIDTH / 2, true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
