import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/src/animated_widget_page.dart';
import 'package:flutter_example/src/custom_transition_page.dart';
import 'package:flutter_example/src/hook_page.dart';
import 'package:flutter_example/src/staggered_animation.dart';
import 'package:provider/provider.dart';

import 'src/basic_animation_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Animation Practice",
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BasicAnimationPage()));
                  },
                  child: Text("basic animation")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReusableAnimationPage()));
                  },
                  child: Text("reusable animation")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HookPage()));
                  },
                  child: Text("animation by Flutter Hook library")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StaggerDemo()));
                  },
                  child: Text("Staggered Animation")),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            child: Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    // secondaryAnimation is used when another route is being animated on the top of the page
                    return ListenableProvider(
                      create: (context) => animation,
                      child: CustomTransitionPage(),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            }));
  }
}
