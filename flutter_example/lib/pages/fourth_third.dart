import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/routes/router.gr.dart';

class FourthThirdPage extends StatelessWidget {
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
              '4-3',
              style: Theme.of(context).textTheme.headline4,
            ),
            OutlinedButton(
                onPressed: () => replaceThisPage(context),
                child: const Text('replace this to Fourth Easter Egg Page')),
            OutlinedButton(
                onPressed: () => navigateBack(context),
                child: const Text('back to main')),
          ],
        ),
      ),
    );
  }
}

void replaceThisPage(BuildContext context) {
  AutoRouter.of(context).replace(const FourthPlusRoute());
}

void navigateBack(BuildContext context) {
  AutoRouter.of(context).navigate(const InitialRoute());
}
