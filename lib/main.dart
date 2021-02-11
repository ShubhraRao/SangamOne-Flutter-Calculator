import 'package:flutter/material.dart';
import 'home_page.dart';
import 'newhome.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Calculator App",
      // theme: new ThemeData.dark(),
      home: new Calculation(),
    );
  }
}