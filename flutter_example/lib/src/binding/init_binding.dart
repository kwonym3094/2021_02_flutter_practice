import 'package:flutter_example/src/controller/app_controller.dart';
import 'package:flutter_example/src/repository/youtube_repository.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(YoutubeRepository(),
        permanent: true); // getService가 아니라 permanent 설정
    Get.put(AppController());
  }
}
