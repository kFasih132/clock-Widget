import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/analog_clock_painter/analog_pixel_clock.dart';

class _LoadingPainter extends CustomPainter {
  _LoadingPainter({this.i = 0.0});
  double i;

  @override
  void paint(Canvas canvas, Size size) {
    final Size(height: h, width: w) = size;
    final center = Offset(w / 2, h / 2);
    final radius = min(w / 2, h / 2) * 0.8;

    final maxCircleRadius = radius * 0.16;

    Paint circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // canvas.drawCircle(center, radius, circlePaint);
    canvas.save();
    canvas.translate(center.dx, center.dy);

    // for dynamically changing the radius
    double getFluctuatingRadius({required double sin}) {
      return maxCircleRadius * (sin.abs() / radius);
    }

    //circles Offsets

    final firstOffset =
        Offset(cos(degToRad(0 + i)) * radius, sin(degToRad(0 + i)) * radius);
    final secOffset =
        Offset(cos(degToRad(36 + i)) * radius, sin(degToRad(36 + i)) * radius);
    final thirdOffset =
        Offset(cos(degToRad(72 + i)) * radius, sin(degToRad(72 + i)) * radius);
    final fourthOffset = Offset(
        cos(degToRad(108 + i)) * radius, sin(degToRad(108 + i)) * radius);
    final fifthOffset = Offset(
        cos(degToRad(144 + i)) * radius, sin(degToRad(144 + i)) * radius);
    final sixthOffset = Offset(
        cos(degToRad(180 + i)) * radius, sin(degToRad(180 + i)) * radius);
    final seventhOffsett = Offset(
        cos(degToRad(216 + i)) * radius, sin(degToRad(216 + i)) * radius);
    // final eightOffsett = Offset(
    //     cos(degToRad(216 + i)) * radius, sin(degToRad(216 + i)) * radius);
    // final ninethOffsett = Offset(
    //     cos(degToRad(216 + i)) * radius, sin(degToRad(216 + i)) * radius);
    // final tenthOffsett = Offset(
    //     cos(degToRad(216 + i)) * radius, sin(degToRad(216 + i)) * radius);

    canvas.drawCircle(
        firstOffset, getFluctuatingRadius(sin: firstOffset.dx), circlePaint);
    canvas.drawCircle(
        secOffset, getFluctuatingRadius(sin: secOffset.dy), circlePaint);
    canvas.drawCircle(
        thirdOffset, getFluctuatingRadius(sin: thirdOffset.dx), circlePaint);
    canvas.drawCircle(
        fourthOffset, getFluctuatingRadius(sin: fourthOffset.dy), circlePaint);
    canvas.drawCircle(
        fifthOffset, getFluctuatingRadius(sin: fifthOffset.dx), circlePaint);
    canvas.drawCircle(
        sixthOffset, getFluctuatingRadius(sin: sixthOffset.dy), circlePaint);
    canvas.drawCircle(seventhOffsett,
        getFluctuatingRadius(sin: seventhOffsett.dx), circlePaint);
    // canvas.drawCircle(
    //     eightOffsett, getFluctuatingRadius(sin: eightOffsett.dy), circlePaint);
    // canvas.drawCircle(ninethOffsett,
    //     getFluctuatingRadius(sin: ninethOffsett.dx), circlePaint);
    // canvas.drawCircle(
    //     tenthOffsett, getFluctuatingRadius(sin: tenthOffsett.dy), circlePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_LoadingPainter oldDelegate) => oldDelegate.i != i;

  @override
  bool shouldRebuildSemantics(_LoadingPainter oldDelegate) =>
      oldDelegate.i != i;
}

class LoadiningWidget extends StatefulWidget {
  const LoadiningWidget({super.key, this.width = 100, this.height = 100});
  final double width;
  final double height;

  @override
  State<LoadiningWidget> createState() => _LoadiningWidgetState();
}

class _LoadiningWidgetState extends State<LoadiningWidget> {
  late Timer _timer;
  double i = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) {
        setState(() {
          i += 1;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LoadingPainter(i: i),
      size: Size(
        widget.width,
        widget.height,
      ),
    );
  }
}
