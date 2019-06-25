import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';

class Loader extends StatefulWidget {
  final double containerSize;

  Loader({this.containerSize = 200.0});

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation_rotation_in;
  Animation<double> animation_rotation_out;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  List<Widget> _initialElementList;

  final double initialElementRadius = 40;
  double elementRadius = 0.0;
  double elementAngel = 0.0;
  int animationDuration = 2;
  String t = 'Anfangszeit';

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(seconds: animationDuration), vsync: this);

    animation_rotation_in = Tween<double>(begin: 0.0, end: pi).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    animation_rotation_out = Tween<double>(begin: pi, end: 2 * pi).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    controller.addListener(() {
      setState(() {
        elementAngel =
            animation_rotation_in.value + animation_rotation_out.value;
        t = (controller.value * animationDuration).toString().substring(0, 4);
      });
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    var elementList = createElementCircle(numberOfDots: 16);
    return Center(
      child: Container(
        //color: Colors.cyan,
        width: widget.containerSize,
        height: widget.containerSize,
        child: Center(
          child: Stack(
            children: <Widget>[
              Stack(
                children:
                    elementList, //<Widget>[Dot(radius: 30.0, color: Colors.amberAccent)],
              ),
              Text(t),
            ],
          ),
        ),
      ),
    );
  }

  createElementCircle({int numberOfDots = 8}) {
    List<Widget> tempElementList = new List<Widget>();
    for (int i = 0; i < numberOfDots; i++) {
      var tempColor = Colors.blueAccent;
      if (i == 0) {
        tempColor = Colors.pinkAccent;
      }
      tempElementList.add(
        Transform.translate(
          offset: Offset(
              initialElementRadius *
                  cos(elementAngel + ((i * 2 * pi) / numberOfDots)),
              initialElementRadius *
                  sin(elementAngel + ((i * 2 * pi) / numberOfDots))),
          child: Element(
            radius: 5.0,
            color: tempColor,
            /*color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
                Random().nextInt(255), Random().nextInt(255)),*/
          ),
        ),
      );
    }
    return tempElementList;
  }
}

class Element extends StatelessWidget {
  final double radius;
  final Color color;

  Element({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
      ),
    );
  }
}
