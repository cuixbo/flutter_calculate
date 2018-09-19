import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class IconSpan extends TextSpan {
  final IconData icon;
  final Color color;
  final double fontSize;
  final GestureRecognizer recognizer;

  IconSpan({this.icon, this.color, this.fontSize, this.recognizer})
      : assert(icon != null),
        super(
            text: String.fromCharCode(icon.codePoint),
            recognizer: recognizer,
            style: TextStyle(
              inherit: false,
              color: color,
              fontSize: fontSize,
              fontFamily: icon.fontFamily,
              package: icon.fontPackage,
            ));
}
