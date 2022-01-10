// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:carbon_footprint/constants/themes.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Indicator extends StatefulWidget {
  Indicator({Key? key}) : super(key: key);

  static String id = "Indicator";

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return ColorLoader3();
  }
}

class ColorLoader3 extends StatefulWidget {
  final double radius;
  final double dotRadius;

  ColorLoader3({this.radius = 30.0, this.dotRadius = 10.0});

  @override
  _ColorLoader3State createState() => _ColorLoader3State();
}

class _ColorLoader3State extends State<ColorLoader3>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;
  late AnimationController controller;

  late double radius;
  late double dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    print(dotRadius);

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 3000),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * animation_radius_in.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [kPrimeColor,kGreenOne,kGreenTwo])
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/bg_carbon.png",
              scale: 1.8,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Carbon Counter",style: TextStyle(
              fontSize: 30
            ),),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100.0,
              height: 100.0,
              //color: Colors.black12,
              child: Center(
                child: RotationTransition(
                  turns: animation_rotation,
                  child: Container(
                    //color: Colors.limeAccent,
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                        
                          Transform.translate(
                            offset: Offset(0.0, 0.0),
                            child: Dot(
                              radius: radius,
                              color: Colors.transparent,
                            ),
                          ),
                          Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: kPrimeColor,
                            ),
                            offset: Offset(
                              radius * cos(0.0),
                              radius * sin(0.0),
                            ),
                          ),
                          Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: kPrimeColor,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 1 * pi / 4),
                              radius * sin(0.0 + 1 * pi / 4),
                            ),
                          ),
                          Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: kPrimeColor,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 2 * pi / 4),
                              radius * sin(0.0 + 2 * pi / 4),
                            ),
                          ),
                          Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: kPrimeColor,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 3 * pi / 4),
                              radius * sin(0.0 + 3 * pi / 4),
                            ),
                          ),
                          Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: kPrimeColor,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 4 * pi / 4),
                              radius * sin(0.0 + 4 * pi / 4),
                            ),
                          ),
                          Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: kPrimeColor,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 5 * pi / 4),
                              radius * sin(0.0 + 5 * pi / 4),
                            ),
                          ),
                          Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: kPrimeColor,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 6 * pi / 4),
                              radius * sin(0.0 + 6 * pi / 4),
                            ),
                          ),
                          Transform.translate(
                            child: Dot(
                              radius: dotRadius,
                              color: kPrimeColor,
                            ),
                            offset: Offset(
                              radius * cos(0.0 + 7 * pi / 4),
                              radius * sin(0.0 + 7 * pi / 4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}