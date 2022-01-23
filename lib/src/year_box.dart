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

    final yearStyle = TextStyle(
      fontFamily: 'gothicA1',
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
    );

    final year = dateTime.toIso8601String().substring(0, 4);

    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
          width: widget.size.width - 4,
          height: widget.size.height - 4,
          color: Colors.white,
          child: Text(
            ' ' + year.substring(0, 2),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.end,
            style: yearStyle,
          )),
      CustomPaint(
        size: Size(widget.size.width, widget.size.height),
        painter: FramePainter(year, yearStyle),
      ),
    ]);
  }
}

class FramePainter extends CustomPainter {
  String year;
  TextStyle yearStyle;

  FramePainter(this.year, this.yearStyle);

  @override
  void paint(Canvas canvas, Size size) {
    Paint framePaint = Paint()
      ..color = Colors.blueAccent
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), framePaint);
    framePaint.color = DARK_BLUE;
    canvas.drawRect(
        Rect.fromLTWH(-3, -3, size.width + 2, size.height + 2), framePaint);

    Paint wheelBorder = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path centuryWheel = Path();
    centuryWheel.moveTo(size.width / 2.15, 0);
    centuryWheel.arcToPoint(Offset(size.width / 2.15, size.height),
        radius: Radius.circular(size.height), clockwise: false);
    canvas.drawPath(centuryWheel, wheelBorder);

    TextSpan decade = TextSpan(text: year[2], style: yearStyle); // Decade digit
    TextPainter decadeText = TextPainter(
      text: decade,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    decadeText.layout();
    decadeText.paint(canvas, Offset(size.width / 2.05, 0));

    final Path decadeWheel = Path();
    decadeWheel.moveTo(size.width * 0.75, 0);
    decadeWheel.lineTo(size.width * 0.75, size.height);
    canvas.drawPath(decadeWheel, wheelBorder);

    TextSpan year1 = TextSpan(text: year[3], style: yearStyle); // Decade digit
    TextPainter year1Text = TextPainter(
      text: year1,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    year1Text.layout();
    year1Text.paint(canvas, Offset(size.width * 0.77, 0));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
