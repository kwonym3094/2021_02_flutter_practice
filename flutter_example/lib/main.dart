import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/routes/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Auto Route & Riverpod',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoRoute Tutorial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () => navigateToSecond(context),
                child: const Text('Second')),
            OutlinedButton(
                onPressed: () => navigateToThird(context),
                child: const Text('Third')),
            OutlinedButton(
                onPressed: () => navigateToRedirect(context),
                child: const Text('Fourth')),
            OutlinedButton(
                onPressed: () => navigateToError(context),
                child: const Text('Error')),
          ],
        ),
      ),
    );
  }
}

void navigateToSecond(BuildContext context) {
  context.router.push(SecondRoute(userId: 'Test Id'));
  // AutoRouter.of(context).pushNamed('/riverpod-basic');
}

void navigateToThird(BuildContext context) {
  context.router.push(ThirdRoute(userName: 'Test Name', points: 23));
}

void navigateToRedirect(BuildContext context) {
  context.router.pushNamed('/redirected');
}

void navigateToError(BuildContext context) {
  context.router.pushNamed('516216');
}
