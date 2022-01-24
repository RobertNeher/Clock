import 'package:clock/src/seconds_weekday_wheel/weekday_dial.dart';
import 'package:flutter/material.dart';

import '../configuration.dart';
import 'border_painter.dart';
import 'curved_text.dart';

class SecondsWeekDayWheel extends StatefulWidget {
  final Size parentSize;
  SecondsWeekDayWheel(this.parentSize, {Key? key}) : super(key: key);

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
            decoration: const BoxDecoration(
                gradient: RadialGradient(
              colors: [LIGHT_BLUE, DARK_BLUE],
              center: Alignment(0, 0),
            )),
            child: Stack(alignment: Alignment.center, children: <Widget>[
              CustomPaint(
                painter: BorderPainter(),
                child: Container(),
              ),
              WeekdayDial(widget.parentSize.width / 8),
            ])),
      ),
    );
  }
}
