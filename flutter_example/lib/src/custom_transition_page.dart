import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTransitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SlidingContainer(
              color: Colors.orange,
              initialOffsetX: 1,
              intervalStart: 0,
              intervalEnd: 0.5,
            ),
          ),
          Expanded(
            child: SlidingContainer(
              color: Colors.green,
              initialOffsetX: -1,
              intervalStart: 0.5,
              intervalEnd: 1.0,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Navigate Back"),
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SlidingContainer extends StatelessWidget {
  final double initialOffsetX;
  final double intervalStart;
  final double intervalEnd;
  final Color color;

  const SlidingContainer(
      {@required this.initialOffsetX,
      @required this.intervalStart,
      @required this.intervalEnd,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<Animation<double>>(context,
        listen:
            false); // listen false means we do not want to rebuild the widget tree whenever the value of the animation is updated

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position:
              Tween<Offset>(begin: Offset(initialOffsetX, 0), end: Offset(0, 0))
                  .animate(CurvedAnimation(
                      parent: animation,
                      curve: Interval(intervalStart, intervalEnd,
                          curve: Curves.easeOutCubic))),
          child: child,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}
