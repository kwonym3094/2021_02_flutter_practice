import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class FourthSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '4-2',
              style: Theme.of(context).textTheme.headline4,
            ),
            OutlinedButton(
                onPressed: () => navigateToNext(context),
                child: const Text('Next')),
          ],
        ),
      ),
    );
  }
}

void navigateToNext(BuildContext context) {
  AutoRouter.of(context).pushNamed('/fourth-third');
}
