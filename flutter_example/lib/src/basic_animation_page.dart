import 'package:flutter/material.dart';
import 'dart:math' as math;

class BasicAnimationPage extends StatefulWidget {
  @override
  _BasicAnimationPageState createState() => _BasicAnimationPageState();
}

class _BasicAnimationPageState extends State<BasicAnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        // interesting point : AnimationController is a subclass of Animation
        duration: Duration(seconds: 3),
        vsync: this); //vsync : set how many times page is updated per second

    // add curves to avoid boring animation
    final curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.easeOut,
    );

    // tweens : can modify the range of generated animation value. Tweens are like modifiers for an animation.
    animation = Tween<double>(
            // more like ColorTween, TextStyleTween
            begin: 0,
            end: 2 * math.pi)
        // other ways to add curves
        .chain(CurveTween(curve: Curves.bounceInOut))
        // .animate(animationController) // change Animatable to Animation
        // .animate(curvedAnimation)
        .animate(animationController)
          ..addListener(() {
            // add Listener to start
            setState(() {});
          })
          ..addStatusListener(
              // make animation play infinitely
              (status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });
    animationController.forward(); // animation start
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: animation.value,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Image.asset('assets/images/image.png'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
