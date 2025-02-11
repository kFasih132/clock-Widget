import 'dart:math';

import 'package:flutter/material.dart';

double degToRad(double deg) {
  return deg * (pi / 180);
}

//so loop Start from 90 so i divide it by 90  = 0 /6 = 60 and 96 -90/6 = 1 which is one minute or sec
double calMinute(double i) {
  return (i - 90) / 6;
}

class _PixelAnalodClockPainter extends CustomPainter {
  _PixelAnalodClockPainter(
      {required this.now,
      this.clockColor = const Color.fromARGB(255, 42, 48, 66),
      this.minuteLineColor = const Color.fromARGB(255, 216, 226, 255),
      this.hourLineColor = const Color.fromARGB(255, 138, 144, 166),
      this.secondsCircleColor = const Color.fromARGB(255, 255, 213, 254)});
  DateTime now;
  Color clockColor;
  Color minuteLineColor;
  Color hourLineColor;
  Color secondsCircleColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Size's of the clock
    final Size(height: h, width: w) = size;
    final center = Offset(w / 2, h / 2);
    final radius = min(w / 2, h / 2);
    final minuteLineWidth = radius * 0.14444;
    final hourLineWidth = radius * 0.144444;
    final minuteLineLength = radius * 0.7;
    final hourLineLength = radius * 0.47;
    final secCircleHeight = radius * 0.89;
    final secCircleRadius = radius * 0.075;
    final angleInRad = 2 * pi / 60;

    //Paths

    //Paints Area
    Paint clockPaint = Paint()
      ..color = clockColor
      ..style = PaintingStyle.fill;

    Paint minuteLinePaint = Paint()
      ..color = minuteLineColor
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = minuteLineWidth;

    Paint hourLinePaint = Paint()
      ..color = hourLineColor
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = hourLineWidth;

    Paint secondsCirclePaint = Paint()
      ..color = secondsCircleColor
      ..style = PaintingStyle.fill;

    // changing the canvas origin to the center of the clock
    canvas.save();
    canvas.translate(center.dx, center.dy);

    Path clockPath = Path();

    // Start from 90 so its 360  is 450 and 6 is becouse  6 deg is 1 minute // 360/60 = 6
    for (double i = 90; i <= 450; i += 6) {
      bool isHour = i % 30 == 0;

      double dx = cos(degToRad(i)) * radius;
      double dy = sin(degToRad(i)) * radius;

      if (isHour) {
        clockPath.arcToPoint(
          Offset(dx, dy),
          radius: Radius.circular(radius * 0.355),
          clockwise: true,
          largeArc: false,
        );
      }

    
    }
    //tilt is for doing 12 , 1 , in mid of curve
    // canvas.rotate(degToRad(15));

    clockPath.close();
    canvas.drawPath(clockPath, clockPaint);

    double hourAngle =
        degToRad((now.hour % 12) * 30 + (now.minute / 60) * 30 - 90);
    canvas.drawLine(
      Offset.zero,
      Offset(cos(hourAngle) * hourLineLength, sin(hourAngle) * hourLineLength),
      hourLinePaint,
    );
    for (var i = 0; i < 60; i++) {
      if (now.minute == i) {
        canvas.drawLine(
            Offset.zero, Offset(0, -minuteLineLength), minuteLinePaint);
      }
      if (now.second == i) {
        canvas.drawCircle(
            Offset(0, -secCircleHeight), secCircleRadius, secondsCirclePaint);
      }
      canvas.rotate(angleInRad);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_PixelAnalodClockPainter oldDelegate) =>
      oldDelegate.now != now;

  @override
  bool shouldRebuildSemantics(_PixelAnalodClockPainter oldDelegate) =>
      oldDelegate.now != now;
}

/// Analog Pixel Clock Widget

class AnalogPixelClock extends StatefulWidget {
  const AnalogPixelClock(
      {super.key,
      this.width = 200,
      this.height = 200,
      required this.now,
      this.clockColor = const Color.fromARGB(255, 42, 48, 66),
      this.minuteLineColor = const Color.fromARGB(255, 216, 226, 255),
      this.hourLineColor = const Color.fromARGB(255, 138, 144, 166),
      this.secondsCircleColor = const Color.fromARGB(255, 255, 213, 254)});
  final double width;
  final double height;
  final DateTime now;
  final Color clockColor;
  final Color minuteLineColor;
  final Color hourLineColor;
  final Color secondsCircleColor;

  @override
  State<AnalogPixelClock> createState() => _AnalogPixelClockState();
}

class _AnalogPixelClockState extends State<AnalogPixelClock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PixelAnalodClockPainter(
          now: widget.now,
          clockColor: widget.clockColor,
          hourLineColor: widget.hourLineColor,
          minuteLineColor: widget.minuteLineColor,
          secondsCircleColor: widget.secondsCircleColor),
      size: Size(widget.width, widget.height),
    );
  }
}
