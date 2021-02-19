import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_example/navigator_test.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => SecondScreen(),
      // 1. args 뽑아내는 방법
      ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
    },
    // 2. 위의 방식처럼 뽑아내지 않는 방법
    onGenerateRoute: (settings) {
      if (settings.name == PassArgumentsScreen.routeName) {
        final ScreenArguments args = settings.arguments;

        return MaterialPageRoute(builder: (context) {
          return PassArgumentsScreen(title: args.title, msg: args.msg);
        });
        // ignore: missing_return
      } else {
        return null;
      }
    },
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('title'),
      ),
      child: Center(
          child: ListView(
        children: [
          ElevatedButton(
            child: Text('Launch screen'),
            onPressed: () {
              // Navigate to the second screen using a named route.
              Navigator.pushNamed(context, '/second');
            },
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Passing Arguments Screen',
                    'new msg is extracted in the build method.',
                  ),
                );
              },
              child: Text("With args")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: ScreenArguments(
                    'Passing Arguments Screen',
                    'new msg is extracted in the build method.',
                  ),
                );
              },
              child: Text("Testing")),
        ],
      )),
    );
  }
}
=======
import 'package:flutter_example/views/home_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Layout Demo',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: Homepage()
    );
  }
}



