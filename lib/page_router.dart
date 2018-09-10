import 'package:flutter/material.dart';

class SlidePageRouter {
  PageRoute pageBuilder(Widget page) {
    return new PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return new SlideTransition(
        position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
            .animate(animation),
        child: child,
      );
    }, pageBuilder: (context, animation, secondaryAnimation) {
      return page;
    });
  }
}
