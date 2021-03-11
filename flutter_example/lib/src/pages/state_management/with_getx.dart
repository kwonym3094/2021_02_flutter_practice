import 'package:flutter/material.dart';
import 'package:flutter_example/src/pages/controller/count_controller_with_getx.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class WithGetX extends StatelessWidget {
  // CountControllerWithGetX _controllerWithGetX = Get.put(CountControllerWithGetX()); // 여기서 인스턴스로 만들어줘도 상관없음
  // 이렇게하면 find 할 필요가 없어짐

  Widget _button(String id) {
    return RaisedButton(
      child: Text(
        "+",
        style: TextStyle(fontSize: 30),
      ),
      onPressed: () {
        Get.find<CountControllerWithGetX>().increase(id); // context가 없다 !!
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "GetX",
            style: TextStyle(fontSize: 30),
          ),
          GetBuilder<CountControllerWithGetX>(
              id: 'first',
              builder: (controller) {
                return Text(
                  "${controller.count}",
                  style: TextStyle(fontSize: 50),
                );
              }), // provider랑 같은 역할
          GetBuilder<CountControllerWithGetX>(
              id: 'second',
              builder: (controller) {
                return Text(
                  "${controller.count}",
                  style: TextStyle(fontSize: 50),
                );
              }),
          _button("first"),
          _button("second"),
        ],
      ),
    );
  }
}
