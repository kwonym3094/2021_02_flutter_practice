import 'package:flutter/material.dart';
import 'package:flutter_example/src/home.dart';
import 'package:flutter_example/src/pages/named/first.dart';
import 'package:flutter_example/src/pages/named/next.dart';
import 'package:flutter_example/src/pages/named/second.dart';
import 'package:flutter_example/src/pages/named/user.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      // home: Home(), << route를 설정하면 빼줘야함
      // named route 설정하는 방법

      initialRoute: "/",
      // 1. 기존 방식
      // routes: {
      //   "/": (context) => Home(),
      //   "/first": (context) => FirstNamedPage(),
      //   "/second": (context) => SecondNamedPage(),
      // },

      // 2. GetX 방식
      //  - animation 추가 할 수 있음
      getPages: [
        GetPage(
          name: "/",
          page: () => Home(),
          transition: Transition.zoom,
        ),
        GetPage(
            name: "/first",
            page: () => FirstNamedPage(),
            transition: Transition.zoom),
        GetPage(
          name: "/second",
          page: () => SecondNamedPage(),
          transition: Transition.zoom,
        ),
        // argument 넘기는법
        GetPage(
            name: "/next",
            page: () => NextPage(),
            transition: Transition.cupertino),
        // params 넘기는 법
        GetPage(
            name: "/user/:uid",
            page: () => UserPage(),
            transition: Transition.cupertino),
      ],
    );
  }
}
