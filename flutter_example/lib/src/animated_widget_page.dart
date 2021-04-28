import 'package:flutter/material.dart';
import 'dart:math' as math;

class ReusableAnimationPage extends StatefulWidget {
  @override
  _ReusableAnimationPageState createState() => _ReusableAnimationPageState();
}

class _ReusableAnimationPageState extends State<ReusableAnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    animation = Tween<double>(begin: 0, end: 2 * math.pi)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(animationController)
          ..addStatusListener((status) {
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
      // Example 1
      // body: AnimatedImage(
      //   animation: animation,
      // ),
      //
      // Example 2 : much optimized
      // body: RotationTransition(
      body: RotatingTransition(
        child: OptimizedAnimatedImage(),
        angle: animation,
        // turns: animation,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

// example 1
class AnimatedImage extends AnimatedWidget {
  // AnimatedWidget needs a constructor field "listenable"

  AnimatedImage({@required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = super.listenable as Animation<double>;

    return Transform.rotate(
      angle: animation.value,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Image.asset('assets/images/image.png'),
      ),
    );
  }
}

// example 2
class OptimizedAnimatedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(30),
      child: Image.asset('assets/images/image.png'),
    );
  }
}

// AnimatedBuilder helps for large anmiated subtrees
class RotatingTransition extends StatelessWidget {
// parameter
  final Widget child;
  final Animation<double> angle;

  const RotatingTransition({
    @required this.angle,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: angle,
      builder: (context, child) {
        return Transform.rotate(
          // this transform widget will be rebuilt every single time the value of the animation changes
          angle: angle.value,
          // but child will not
          child: child,
        );
      },
      child: child,
      // this child will be pre-built by the AnimatedBuilder for performance optimizations.
      // so it will not be rebuilt on every new animation (or animation tick) !!!
    );
  }
}
