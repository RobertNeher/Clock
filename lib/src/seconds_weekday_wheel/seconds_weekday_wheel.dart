import 'package:flutter/material.dart';

import '../configuration.dart';
import 'package:clock/src/seconds_weekday_wheel/seconds_dial.dart';
import 'package:clock/src/seconds_weekday_wheel/ticks_painter.dart';
import 'package:clock/src/seconds_weekday_wheel/weekday_dial.dart';

class SecondsWeekDayWheel extends StatefulWidget {
  final Size parentSize;
  const SecondsWeekDayWheel(this.parentSize, {Key? key}) : super(key: key);

  @override
  _SecondsWeekDayWheelState createState() => _SecondsWeekDayWheelState();
}

class _SecondsWeekDayWheelState extends State<SecondsWeekDayWheel> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: ClipOval(
        clipBehavior: Clip.hardEdge,
        child: Container(
            width: widget.parentSize.width,
            height: widget.parentSize.width,
            decoration: const BoxDecoration(
                gradient: RadialGradient(
              colors: [LIGHT_BLUE, DARK_BLUE],
              center: Alignment(0, 0),
            )),
            child: Stack(alignment: Alignment.center, children: <Widget>[
              WeekdayDial(widget.parentSize),
              CustomPaint(
                  painter: TicksPainter(),
                  child: Container(
                    width: widget.parentSize.width,
                    height: widget.parentSize.width,
                  )),
              SecondsDial(widget.parentSize.width / 2),
            ])),
      ),
    );
  }
}
