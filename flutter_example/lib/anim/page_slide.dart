import 'package:flutter/cupertino.dart';

Route createRoute(Widget widget) {
  return PageRouteBuilder<SlideTransition>(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero);
        var curveTween = CurveTween(curve: Curves.ease);

        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: child,
        );
      });
}
