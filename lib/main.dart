import 'package:flutter/material.dart';
import 'dart:math';

import './loader_BigDotCircleIllusion.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';
    print("Startet App");
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Loader(), //ImageGrid(),
      ),
    );
  }
}