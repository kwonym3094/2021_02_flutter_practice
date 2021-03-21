import 'package:flutter_example/src/models/youtube_video_result.dart';
import 'package:flutter_example/src/repository/youtube_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult().obs;

  @override
  void onInit() {
    _videoLoad();
    super.onInit();
  }

  void _videoLoad() async {
    YoutubeVideoResult youtubeVideoResult =
        await YoutubeRepository.to.loadVideos(); // 등록해야 사용할 수 있음, binding에 추가

    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items.length > 0) {
      youtubeResult(youtubeVideoResult);
    }
  }
}
