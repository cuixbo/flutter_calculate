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
          contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 0.5, color: Theme.of(context).dividerColor, style: BorderStyle.solid)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 0.5, color: Colors.blue, style: BorderStyle.solid)),
        ),
      ),
      home: new MyHomePage(title: 'Flutter Calculate Home Page'),
    );
  }
}
