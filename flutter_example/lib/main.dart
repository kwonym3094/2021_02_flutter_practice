import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/route/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();

    return MaterialApp.router(
      title: 'Flutter Demo',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Tutorial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                routeToNext(context, RiverpodBasic());
              },
              child: Text('Riverpod Basic'),
            ),
            TextButton(
              onPressed: () {
                routeToNext(context, WeatherSearchRoute());
              },
              child: Text('Riverpod + StateNotifier'),
            ),
          ],
        ),
      ),
    );
  }
}

void routeToNext(BuildContext context, PageRouteInfo info) {
  AutoRouter.of(context).push(info);
}
