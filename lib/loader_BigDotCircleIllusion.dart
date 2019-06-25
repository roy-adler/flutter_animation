import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';

class Loader extends StatefulWidget {
  Loader() {
    print('starte Programm');
  }

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  final double containerSize = 500.0;
  final int elementNumber = 20;
  final double initialElementRadius = 150.0;
  final double elementSize = 10.0; //Size of the Elements
  final double splitValue = 0.0; //Better be between 0 and 1
  final double sizeChangeFactor = 6.14;
  final int animationDuration = 12; //Duration in seconds
  final double rotations = 1;
  final double _withoutChangeSize = 1; // 0 or 1

  AnimationController controller;
  List<Animation<double>> animation_change_size_list =
      new List<Animation<double>>();
  Animation<double> animation_rotation;

  List<double> elementSizeChange;

  @override
  void initState() {
    elementSizeChange = List<double>(elementNumber);

    super.initState();

    controller = AnimationController(
        duration: Duration(seconds: animationDuration), vsync: this);

    for (int i = 0; i < animationDuration; i++) {
      double animationBegin = i.toDouble() / animationDuration;
      double animationEnd = (i.toDouble() + 1) / animationDuration;
      animation_change_size_list
          .add(Tween<double>(begin: 0, end: -2 * pi).animate(
        CurvedAnimation(
          parent: controller,
          curve:
              Interval(animationBegin, animationEnd, curve: Curves.easeInOut),
        ),
      ));
    }

    animation_rotation =
        Tween<double>(begin: 0, end: -2 * pi * rotations).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        for (int i = 0; i < elementNumber; i++) {
          double animation_change_size_value = 0;
          for (int i = 0; i < animation_change_size_list.length; i++) {
            animation_change_size_value += animation_change_size_list[i].value*_withoutChangeSize;
          }
          double tempAngle = i * (2 * pi) / elementNumber.toDouble() +
              animation_change_size_value +
              animation_rotation.value;
          double distributionFunction = cos(tempAngle) + sin(tempAngle);
          double tempChange = 0;
          //Change the Function to Change the distribution
          if (distributionFunction > splitValue) {
            tempChange = sizeChangeFactor * (pow(distributionFunction, 2));
          }

          elementSizeChange[i] = elementSize + tempChange;
        }
      });
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //color: Colors.black12,
        width: containerSize,
        height: containerSize,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Stack(children: getElementCircle()),
                ],
              ),
            ]),
      ),
    );
  }

  List<Widget> getElementCircle() {
    List<Widget> ret = <Widget>[];
    for (int i = 0; i < elementNumber; i++) {
      double tempElementSize = elementSizeChange[i];
      double tempAngle = i * (2 * pi) / elementNumber.toDouble();
      ret.add(
        Transform.translate(
          offset: Offset(initialElementRadius * cos(tempAngle),
              initialElementRadius * sin(tempAngle)),
          child: Element(color: Colors.blueAccent, size: tempElementSize),
        ),
      );
    }
    return ret;
  }
}

class Element extends StatelessWidget {
  final Color color;
  final size;

  Element({this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
    );
  }
}
