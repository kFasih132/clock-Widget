import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/analog_clock_painter/analog_pixel_clock.dart';
import 'package:flutter_analog_clock/loader/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  Duration duration = const Duration(milliseconds: 300);
  double containerSize = 80;
  double containerRadius = 80.0;
  double iconSize = 30;

  void onContainerTap() {
    setState(() {
      crossFadeState = crossFadeState == CrossFadeState.showFirst
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst;
      containerSize = containerSize == 90 ? 80 : 90;
      containerRadius = containerRadius == 80.0 ? 20.0 : 80.0;
    });
  }

  @override
  void initState() {
    super.initState();
    // Timer.periodic(
    //   const Duration(seconds: 1),
    //   (timer) {
    //     setState(() {});
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 207, 185),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          spacing: 50,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // GestureDetector(
            //     onTap: onContainerTap,
            //     child: AnimatedContainer(
            //       duration: duration,
            //       height: containerSize,
            //       width: containerSize,
            //       curve: Curves.bounceOut,
            //       decoration: BoxDecoration(
            //           color: Colors.blue,
            //           borderRadius: BorderRadius.circular(containerRadius)),
            //       child: Center(
            //         child: AnimatedCrossFade(
            //             firstChild: Icon(
            //               Icons.play_arrow,
            //               size: iconSize,
            //             ),
            //             secondChild: Icon(
            //               Icons.pause,
            //               size: iconSize,
            //             ),
            //             crossFadeState: crossFadeState,
            //             duration: duration),
            //       ),
            //     )),

            // CardAnimation()

            AnalogPixelClock(
              
            ),
            // LoadiningWidget()
          ],
        ),
      ),
    );
  }
}
