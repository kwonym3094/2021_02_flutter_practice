import 'package:flutter/cupertino.dart';
import 'package:flutter_example/src/models/youtube_video_result.dart';
import 'package:flutter_example/src/repository/youtube_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult(items: []).obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    _videoLoad();
    _event();
    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      // print(scrollController.position.pixels); // 스크롤 현재 위치 알기
      print(scrollController.position.maxScrollExtent);
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          youtubeResult.value.nextPageToken != "") {
        _videoLoad();
      }
    });
  }

  void _videoLoad() async {
    YoutubeVideoResult youtubeVideoResult = await YoutubeRepository.to
        .loadVideos(youtubeResult.value.nextPageToken ??
            ""); // 등록해야 사용할 수 있음, binding에 추가

    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items.length > 0) {
      youtubeResult.update((youtube) {
        youtube.nextPageToken = youtubeVideoResult.nextPageToken;
        youtube.items.addAll(youtubeVideoResult
            .items); // 이렇게만 하면 문제 발생 -> nextPageToken 이 업데이트 되지 않음 (초기에 받은 값에는 nextPageToken 값이 없으므로)
      });
    }
  }
}
