import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CountControllerWithGetX extends GetxController {
  int count = 0;
  void increase(String id) {
    count++;
    update([id]);
  }
}
