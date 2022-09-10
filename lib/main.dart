// import 'package:clock/src/seconds_weekday_wheel/seconds_weekday_wheel.dart';
import 'package:flutter/material.dart';

import 'package:clock/src/configuration.dart';
import 'package:clock/src/clock_face.dart';

void main() {
  runApp(const MyWatchApp());
}

class MyWatchApp extends StatelessWidget {
  const MyWatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TITLE,
      color: Colors.transparent,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WatchPage(title: TITLE),
    );
  }
}

class WatchPage extends StatefulWidget {
  const WatchPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  @override
  Widget build(BuildContext context) {
    Size size = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraints) {
                    return Container(
                        alignment: Alignment.center,
                        height: size.height - 100,
                        child: ClockFace(
                            size)); //ClockFace(size)                   );
                  })
                ],
              ),
            ]));
  }
}
