import 'package:flutter/material.dart';
import 'package:flutter_example/src/pages/normal/second.dart';
import 'package:get/get.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text("다음페이지 이동"),
                onPressed: () {
                  Get.to(SecondPage());
                })
          ],
        ),
      ),
    );
  }
}
