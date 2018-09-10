import 'package:flutter/material.dart';
import 'package:flutter_calculate/pages/calculate_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Calculate',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: new InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.0, color: Colors.black12, style: BorderStyle.solid)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.0, color: Colors.blue, style: BorderStyle.solid)),
        ),
      ),
      home: new MyHomePage(title: 'Flutter Calculate Home Page'),
    );
  }
}
