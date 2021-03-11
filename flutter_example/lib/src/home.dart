import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/src/pages/dependencies/dependency_manage_page.dart';
import 'package:flutter_example/src/pages/normal/first.dart';
import 'package:flutter_example/src/pages/state_management/reactive_state_manage_page.dart';
import 'package:flutter_example/src/pages/state_management/simple_state_manage_page.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("라우트 관리 홈"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text("일반적인 라우트"),
                onPressed: () {
                  // 1.일반적 방법
                  /** 
                   * Navigator.of(context)
                   * .push(MaterialPageRoute(builder: (_) => FirstPage()));
                  */

                  // 2. getX에서의 방법
                  Get.to(FirstPage());
                }),
            RaisedButton(
              child: Text("Named 라우트"),
              onPressed: () {
                // 1. 기존 방식
                // Navigator.of(context).pushNamed("/first");

                // 2. GetX 방식
                Get.toNamed("/first");
              },
            ),
            RaisedButton(
              child: Text("Argument 전달"),
              onPressed: () {
                // arguments 를 넘기는 방법

                // Get.toNamed("/next", arguments: "개남"); // string
                // Get.toNamed("/next", arguments: 3); // int
                // Get.toNamed("/next", arguments: {"name": "개남", "age": 23}); // map
                // class object
                Get.toNamed("/next", arguments: User(name: "테스트", age: 23));
              },
            ),
            RaisedButton(
              child: Text("동적 url"),
              onPressed: () {
                Get.toNamed("/user/28357"); // 하나만
                // Get.toNamed("/user/28357?name=개남&age=22"); // 여러개 : 업데이트 이후 에러 발생
              },
            ),

            // ------ 상태 관리 -------
            //  - 단순 상태관리
            //  -
            RaisedButton(
              child: Text("단순상태관리"),
              onPressed: () {
                Get.to(SimpleStateManagePage()); // 하나만
                // Get.toNamed("/user/28357?name=개남&age=22"); // 여러개 : 업데이트 이후 에러 발생
              },
            ),
            RaisedButton(
              child: Text("반응형상태관리"),
              onPressed: () {
                Get.to(ReactiveStateManagePage());
              },
            ),
            // instance 화 하는 방법 정리
            // (Get.put(CountControllerWithGetX()); << 처럼 instance로 만드는 방법)
            RaisedButton(
              child: Text("의존성 관리"),
              onPressed: () {
                Get.to(DependencyManagePage());
              },
            ),
            RaisedButton(
              child: Text("바인딩"),
              onPressed: () {
                Get.toNamed('/binding');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  String name;
  int age;
  User({this.name, this.age});
}
