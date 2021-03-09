import 'package:flutter/material.dart';
import 'package:flutter_example/src/home.dart';
import 'package:get/get.dart';

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page with Argument"),
      ),
      body: Center(
        child: Column(
          children: [
            // Text("${Get.arguments}") // 기본 타입
            // Text("${Get.arguments['name']}"),
            // Text("${Get.arguments['age']}"), // map
            Text("${(Get.arguments as User).name}"),
            Text("${(Get.arguments as User).age}"), // class object
          ],
        ),
      ),
    );
  }
}
