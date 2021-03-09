import 'package:flutter/material.dart';
import 'package:flutter_example/src/pages/controller/count_controller_with_getx.dart';
import 'package:flutter_example/src/pages/controller/count_controller_with_provider.dart';
import 'package:flutter_example/src/pages/state_management/with_getx.dart';
import 'package:flutter_example/src/pages/state_management/with_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReactiveStateManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(
        CountControllerWithGetX()); // 인스턴스로 만들어 주는 것 << 이렇게 정의하고 나면 어디서든 사용이 가능함
    return Scaffold(
      appBar: AppBar(
        title: Text('단순상태관리'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "",
              style: TextStyle(fontSize: 50),
            ),
            RaisedButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
