import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page with Argument"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${Get.parameters['uid']}"), // /user/~~~ 로 넘어왔을 때
            // Text("${Get.parameters['uid']}"), // /user?~~&~~ 로 넘어왔을 때
            // Text("${Get.parameters['name']} 님 안녕하세요"), // /user?~~&~~ 로 넘어왔을 때
            // Text("${Get.parameters['age']} 살 이군요"), // /user/~~~~?~~&~~ 로 넘어왔을 때
          ],
        ),
      ),
    );
  }
}
