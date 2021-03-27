import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_example/views/home_page.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'helper/scrollview_no_glow.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // 플랫폼 판단
  bool get isiOS =>
      foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    if (this.isiOS) {
      return CupertinoApp(
          title: 'Flutter Layout Demo',
          debugShowCheckedModeBanner: false,
          home: Homepage());
    } else {
      return MaterialApp(
          title: 'Flutter Layout Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          builder: (context, child) {
            return ScrollConfiguration(behavior: NoScrollGlow(), child: child);
          },
          home: Homepage());
    }
  }
}
