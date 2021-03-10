// binding 을 따로 분리하는 방법
import 'package:flutter_example/src/pages/controller/count_controller_with_getx.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class BindingPage implements Bindings {
  @override
  void dependencies() {
    Get.put(CountControllerWithGetX());
  }
}
