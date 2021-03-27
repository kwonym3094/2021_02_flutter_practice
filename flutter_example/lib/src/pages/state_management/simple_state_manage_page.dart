import 'package:flutter/material.dart';
import 'package:flutter_example/src/pages/controller/count_controller_with_getx.dart';
import 'package:flutter_example/src/pages/controller/dependency_controller.dart';
import 'package:get/get.dart';

class SimpleStateManagePage extends StatelessWidget {
  // 1-1. 클래스가 생성될때 instance 화 해줘도 상관없음
  CountControllerWithGetX _controller =
      Get.put(CountControllerWithGetX()); // 장점 : find 할 필요가 없음

  DependencyController _dependencyController = Get.put(DependencyController());

  @override
  Widget build(BuildContext context) {
    // Get.put(CountControllerWithGetX()); // 1. instance 화
    return Scaffold(
      appBar: AppBar(
        title: Text("단순상태관리"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<CountControllerWithGetX>(
              // 2. builder 생성
              id: "first",
              builder: (controller) {
                return Text(
                  "${_controller.count}",
                  style: TextStyle(fontSize: 50),
                );
              },
            ),
            RaisedButton(
              child: Text(
                "+",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                Get.find<CountControllerWithGetX>()
                    .increase("first"); // 3. 찾아서 사용
              },
            ),
            GetBuilder<CountControllerWithGetX>(
              // 4. builder 만들어서 사용
              id: "second",
              builder: (controller) {
                return Text(
                  "${controller.count}",
                  style: TextStyle(fontSize: 50),
                );
              },
            ),
            RaisedButton(
              child: Text(
                "+",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                Get.find<CountControllerWithGetX>().increase("second");
              },
            ),
          ],
        ),
      ),
    );
  }
}
