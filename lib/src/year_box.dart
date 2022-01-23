// import 'package:intl/intl.dart';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:clock/src/configuration.dart';

class YearBox extends StatefulWidget {
  Size size;
  YearBox(this.size, {Key? key}) : super(key: key);

  @override
  _YearBoxState createState() => _YearBoxState();
}

class _YearBoxState extends State<YearBox> {
  final DateTime dateTime = DateTime.now();
  Size parentSize = Size.zero;
  double radius = 0;
  double fontSize = 0;
  Size boxSize = Size.infinite;
  Offset yearPosition = Offset.zero;
  String year = '';

  @override
  Widget build(BuildContext context) {
    parentSize = widget.size;
    radius = parentSize.width / 2;

    fontSize = radius / 16;
    // boxSize = Size(radius / 16, fontSize + 4);

    year = dateTime.toIso8601String().substring(0, 4);

    return Stack(alignment: Alignment.center, children: <Widget>[
      CustomPaint(
        size: Size(widget.size.width, widget.size.height),
        painter: FramePainter(),
      ),
      Container(
          width: widget.size.width - 4,
          height: widget.size.height - 4,
          color: Colors.white,
          child: Text(
            ' ' + year.substring(0, 2),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: 'gothicA1',
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
            ),
          )),
    ]);
  }
}

class FramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint framePaint = Paint()
      ..color = DARK_BLUE
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), framePaint);

    Paint centurySeperator = Paint()
      ..color = Colors.purple
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final Path centuryArc = Path();
    centuryArc.moveTo(size.width / 2, size.height / 2);
    centuryArc.arcToPoint(Offset(size.width / 2, size.height),
        radius: Radius.circular(size.height), clockwise: true);
    canvas.drawPath(centuryArc, centurySeperator);
  }

  @override
  bool shouldRepaint(CustomPainter olDelegate) {
    return false;
  }
}
