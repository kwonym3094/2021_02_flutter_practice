import 'package:flutter/material.dart';
import 'package:flutter_example/src/home.dart';
import 'package:flutter_example/src/pages/binding/binding.dart';
import 'package:flutter_example/src/pages/binding/binding_page.dart';
import 'package:flutter_example/src/pages/controller/count_controller_with_getx.dart';
import 'package:flutter_example/src/pages/controller/dependency_controller.dart';
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
        // binding
        GetPage(
            name: "/binding",
            page: () => BindingPage(),
            transition: Transition.downToUp,
            // 가장 앞단에 binding을 설정할 수 있음
            binding: BindingPageBindng(), //BindingsBuilder(() {
              // Get.put(
                  // CountControllerWithGetX()); // 최초 라우트 설정할 때 해주면서 더 이상 신경쓰지 않아도 됨
                  // 따로 관리 가능함 (BindingPage.dart 참고)
            // }
            )),
      ],
    );
  }
}
