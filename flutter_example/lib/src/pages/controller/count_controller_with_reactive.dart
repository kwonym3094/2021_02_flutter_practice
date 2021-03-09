import 'package:get/get.dart';

class CountControllerWithReactive {
  // GetxController 안넣어도됨
  // observable을 만들 수 있음

  RxInt count = 0.obs; // 반응형으로 관리하겠다는 의미. 이전에 get package 포함되있어야함.
  void increase() {
    count++;
  }
}
