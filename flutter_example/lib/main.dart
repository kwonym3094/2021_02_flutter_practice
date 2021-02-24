import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/helper/authenticate.dart';
import 'package:flutter_example/navigator_test.dart';
import 'package:flutter_example/views/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xff154C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Authenticate(),
      ),
    );
  }
}












