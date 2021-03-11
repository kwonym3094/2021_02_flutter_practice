import 'package:flutter/material.dart';
import 'package:flutter_example/src/pages/controller/count_controller_with_getx.dart';
import 'package:flutter_example/src/pages/controller/count_controller_with_provider.dart';
import 'package:flutter_example/src/pages/controller/count_controller_with_reactive.dart';
import 'package:flutter_example/src/pages/state_management/with_getx.dart';
import 'package:flutter_example/src/pages/state_management/with_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReactiveStateManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(
        CountControllerWithReactive()); // 인스턴스로 만들어 주는 것 << 이렇게 정의하고 나면 어디서든 사용이 가능함
    return Scaffold(
      appBar: AppBar(
        title: Text('단순상태관리'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GetX",
              style: TextStyle(fontSize: 30),
            ),
            Obx(() {
              print("UPDATE!!!!!!");
              return Text(
                "${Get.find<CountControllerWithReactive>().count.value}",
                style: TextStyle(fontSize: 50),
              );
            }), // ~.value 까지 넣어줘야함
            // 타입을 지정하지 않고 obs로 선언한 observable의 변화를 감지했을 때 바로 obx에서 업데이트해줌
            // 단, obs 로 선언한 값을 안에 꼭 넣어줘야 함! 아니면 오류가 날 수 있음.

            // 또 다른 방법
            // GetX(
            //   builder: (_) {
            //     return Text(
            //       "${Get.find<CountControllerWithReactive>().count.value}",
            //       style: TextStyle(fontSize: 50),
            //     );
            //   },
            // ),

            RaisedButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  Get.find<CountControllerWithReactive>().increase();
                }),

            // reactive 방식의 장점: 값이 변화가 생길 때만 화면 update생김 (위의 print("UPDATE") 참고)
            //  즉, 리소스를 덜 사용할 수 있음.
            RaisedButton(
                child: Text(
                  "5로 변경",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  Get.find<CountControllerWithReactive>().putNumber(5);
                }),
          ],
        ),
      ),
    );
  }
}
