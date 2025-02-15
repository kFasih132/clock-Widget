import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

double degToRad(double deg) {
  return deg * (pi / 180);
}

double calMinute(double i) {
  return (i - 90) / 6;
}

class _PixelAnalodClockPainter extends CustomPainter {
  _PixelAnalodClockPainter(
      {required this.now,
      this.textStyle = const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 194, 193, 201),
          fontWeight: FontWeight.bold),
      this.clockColor = const Color.fromARGB(255, 42, 48, 66),
      this.minuteLineColor = const Color.fromARGB(255, 216, 226, 255),
      this.hourLineColor = const Color.fromARGB(255, 138, 144, 166),
      this.secondsCircleColor = const Color.fromARGB(255, 255, 213, 254)});
  DateTime now;
  Color clockColor;
  Color minuteLineColor;
  Color hourLineColor;
  Color secondsCircleColor;
  TextStyle textStyle;

  @override
  void paint(Canvas canvas, Size size) {
    // Size's of the clock
    final Size(height: h, width: w) = size;
    final center = Offset(w / 2, h / 2);
    final radius = min(w / 2, h / 2);
    final minuteLineWidth = radius * 0.14444;
    final hourLineWidth = radius * 0.144444;
    final minuteLineLength = radius * 0.63;
    final hourLineLength = radius * 0.47;
    final secCircleHeight = radius * 0.8;
    final secCircleRadius = radius * 0.075;
    final angleInRad = 2 * pi / 60;
    const Map<int, String> weeks = <int, String>{
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
      7: 'Sun'
    };
    final txtDate = '${now.day} ${weeks[now.weekday]}';

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

    // its private function in class
    _drawWavyClockShape(canvas, radius, center, clockPaint);

    canvas.save();
    canvas.translate(center.dx, center.dy);

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
        canvas.save();
        // drawCurvedText(canvas, txtDate, center, radius);
        for (var i = 0; i < txtDate.length; i++) {
          final text = TextSpan(text: txtDate[i], style: textStyle);
          final textPainter = TextPainter(
            text: text,
            textDirection: TextDirection.ltr,
          );

          textPainter.layout();

          textPainter.paint(
              canvas,
              Offset(secCircleHeight * 0.95,
                  sin(degToRad(270 + i * 1.0) * secCircleHeight)));
          canvas.rotate(degToRad(i + textPainter.width * 1.2));
        }
        canvas.restore();
      }

      canvas.rotate(angleInRad);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_PixelAnalodClockPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_PixelAnalodClockPainter oldDelegate) => true;
}

void _drawWavyClockShape(
    Canvas canvas, double radius, Offset center, Paint clockPaint) {
  canvas.save();
  canvas.translate(center.dx, center.dy);
  Path clockPath = Path();
  clockPath.moveTo(cos(0) * radius, sin(0) * radius);

  // Start from 90 so its 360  is 450 and 6 is becouse  6 deg is 1 minute // 360/60 = 6
  for (double i = 0; i < 360; i += 6) {
    bool isHour = i % 30 == 0;

    if (isHour) {
      Offset cubicToPoint1Offset =
          Offset(cos(degToRad(i + 5)) * radius, sin(degToRad(i + 5)) * radius);
      Offset cubicToPoint2Offset = Offset(cos(degToRad(i + 15)) * radius * 0.88,
          sin(degToRad(i + 15)) * radius * 0.88);
      Offset endPointOffset = Offset(cos(degToRad(i + 15)) * radius * 0.92,
          sin(degToRad(i + 15)) * radius * 0.92);
///////////////////////////////////////////////////////////////
      Offset quadraticBezierTo1Offset = Offset(
          cos(degToRad(i + 25)) * radius, sin(degToRad(i + 25)) * radius);
      Offset quadraticBezierTo2Offset = Offset(
          cos(degToRad(i + 30)) * radius, sin(degToRad(i + 30)) * radius);

      clockPath.cubicTo(
          cubicToPoint1Offset.dx,
          cubicToPoint1Offset.dy,
          cubicToPoint2Offset.dx,
          cubicToPoint2Offset.dy,
          endPointOffset.dx,
          endPointOffset.dy);
      clockPath.quadraticBezierTo(
          quadraticBezierTo1Offset.dx,
          quadraticBezierTo1Offset.dy,
          quadraticBezierTo2Offset.dx,
          quadraticBezierTo2Offset.dy);
    }
  }

  clockPath.close();
  canvas.drawPath(clockPath, clockPaint);
  canvas.restore();
}

void drawCurvedText(Canvas canvas, String text, Offset center, double radius) {
  final textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  final double totalAngle = pi / 2; // Adjust curve spread
  final double startAngle = -totalAngle / 2; // Centering it
  final double angleStep = totalAngle / (text.length - 1);

  for (int i = 0; i < text.length; i++) {
    final char = text[i];
    textPainter.text = TextSpan(
      text: char,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );

    textPainter.layout();
    double angle = startAngle + (i * angleStep);

    double x = center.dx + radius * cos(angle) - textPainter.width / 2;
    double y = center.dy + radius * sin(angle) - textPainter.height / 2;

    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(angle + pi / 2); // Rotate text along curve
    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }
}

/// Analog Pixel Clock Widget

class AnalogPixelClock extends StatefulWidget {
  const AnalogPixelClock(
      {super.key,
      this.width = 200,
      this.height = 200,
      required this.now,
      this.textStyle = const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 194, 193, 201),
          fontWeight: FontWeight.bold),
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
  final TextStyle textStyle;

  @override
  State<AnalogPixelClock> createState() => _AnalogPixelClockState();
}

class _AnalogPixelClockState extends State<AnalogPixelClock> {
  late Timer _timer;
  int sec = 0;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        sec = DateTime.now().second;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PixelAnalodClockPainter(
          now: widget.now,
          textStyle: widget.textStyle,
          clockColor: widget.clockColor,
          hourLineColor: widget.hourLineColor,
          minuteLineColor: widget.minuteLineColor,
          secondsCircleColor: widget.secondsCircleColor),
      size: Size(widget.width, widget.height),
    );
  }
}
