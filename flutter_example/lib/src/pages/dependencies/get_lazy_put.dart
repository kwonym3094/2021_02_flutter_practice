import 'package:flutter/material.dart';
import 'package:flutter_example/src/pages/controller/dependency_controller.dart';
import 'package:get/get.dart';

class GetLazyPutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RaisedButton(
        onPressed: () {
          // 여러번 만들어지는지 확인하는 방법 hashCode()
          Get.find<DependencyController>().increase();
        },
      ),
    );
  }
}
