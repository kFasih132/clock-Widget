import 'dart:math';

import 'package:flutter/material.dart';

class CardAnimation extends StatefulWidget {
  const CardAnimation(
      {super.key,
      this.topCardColor = const Color.fromARGB(255, 8, 186, 153),
      this.bottomCardColor = const Color.fromARGB(255, 219, 107, 92),
      this.duration = const Duration(milliseconds: 300)});
  final Color topCardColor;
  final Color bottomCardColor;
  final Duration duration;

  @override
  State<CardAnimation> createState() => _CardAnimationState();
}

class _CardAnimationState extends State<CardAnimation> {
  double initBottomCardsheight = 80.0;
  double initBottomCardswidth = 100.0;
  double initTopCardsheight = 80.0;
  double initTopCardswidth = 100.0;
  double initCardsRadius = 20.0;
  double iconSize = 30.0;

  Widget topContainerChild = Center(
      child: Text(
    'Card ->',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ));
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  void onDetailTap() {
    setState(() {
      initBottomCardsheight = initBottomCardsheight == 300 ? 500 : 300;
    });
  }

  void onTopContainerTap() {
    setState(() {
      crossFadeState = crossFadeState == CrossFadeState.showFirst
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst;
      topContainerChild = topContainerChild.runtimeType == Center
          ? CardDetails()
          : Center(
              child: Text(
              'Card ->',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ));
      initBottomCardsheight =
          initBottomCardsheight == 300 || initBottomCardsheight == 500
              ? 80
              : 300;
      initBottomCardswidth = initBottomCardswidth == 370 ? 100 : 370;
      initTopCardsheight = initTopCardsheight == 200 ? 80 : 200;
      initTopCardswidth = initTopCardswidth == 350 ? 100 : 350;
    });
  }

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var Size(height: h, width: w) = size;
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          duration: widget.duration,
          height: initBottomCardsheight,
          width: initBottomCardswidth,
          curve: Curves.bounceOut,
          decoration: BoxDecoration(
              color: widget.bottomCardColor,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '''Rs 1260 + tax(one time)
                    
  * Global acceptance at over 53 million merchants around the world                                  
  * One-time fee of Rs. 1,260 + tax and no annual fee             

                    ''',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: onDetailTap,
                      child: Text(
                        'Details ->',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '''
* 3D secured for online shopping Advanced card controls in your app
* Contactless payments (tap to pay)
                      ''',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onTopContainerTap,
          child: AnimatedContainer(
            duration: widget.duration,
            height: initTopCardsheight,
            width: initTopCardswidth,
            curve: Curves.bounceOut,
            decoration: BoxDecoration(
                color: widget.topCardColor,
                borderRadius: BorderRadius.circular(20)),
            child: topContainerChild,
          ),
        ),
      ],
    );
  }
}

class CardDetails extends StatelessWidget {
  const CardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return LayoutBuilder(
      builder: (context, constraints) {
        var h = constraints.maxHeight;
        var w = constraints.maxWidth;
        return Padding(
          padding: EdgeInsets.all(
              min(constraints.maxWidth, constraints.maxHeight) * 0.1),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Debt Card', style: style),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'SadaPay',
                  style: style,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '4000 1234 5678 9010',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '01/25',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '951',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Master Card',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
