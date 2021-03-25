import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReactiveStateManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ReactiveController()); // 1. instance 화

    print("start!!!!");
    return Scaffold(
      appBar: AppBar(
        title: Text("반응형상태관리"),
      ),
      body: Obx(
          // 2. obx 감싸기
          // 여기서는 필자 실수로 전체에 감쌌는데 딱 업데이트 되는 부분만 감싸면 좋을 듯
          () {
        print("UPDATE!!!!!");
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Getx",
                style: TextStyle(fontSize: 30),
              ),
              // GetX(builder: (_) {
              //   return Text(
              //     "${Get.find<ReactiveController>().count.value}", // 3. Get.put<ReactiveController>().count.value 이런식으로 사용
              //     style: TextStyle(fontSize: 50),
              //   );
              // }), // 3-1. GetX 안에 builder 사용하여 정의
              Text(
                "${Get.find<ReactiveController>().count.value}", // 3. Get.put<ReactiveController>().count.value 이런식으로 사용
                style: TextStyle(fontSize: 50),
              ),
              RaisedButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  Get.find<ReactiveController>().increase();
                },
              ),
              RaisedButton(
                child: Text(
                  "5로 변경",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  Get.find<ReactiveController>().putNumber(5);
                },
              )
            ],
          ),
        );
      }),
    );
  }
}

class ReactiveController extends GetxController {
  RxInt count = 0.obs;
  increase() {
    count++;
  }

  putNumber(int number) {
    count(number);
  }

  // 4. 다음 lifecycle은 해야할일이 있을 때만 사용하자!!!!
  @override
  void onInit() {
    // 5. 다음 것들 잘 이해하고 있기 (listener에는 무조건 )
    // ever(listener, callback); // 계속 수행
    // once(listener, callback); // 처음 한번 수행
    // debounce(listener, callback); //
    // interval(listener, callback); // 일정 시간 간격으로 수행
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  // TODO: implement onDelete
  get onDelete => super.onDelete;
}
