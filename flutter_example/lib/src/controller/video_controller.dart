import 'package:flutter_example/src/models/statistics.dart';
import 'package:flutter_example/src/models/video.dart';
import 'package:flutter_example/src/models/youtuber.dart';
import 'package:flutter_example/src/repository/youtube_repository.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  Video video;
  VideoController({this.video});

  Rx<Statistics> statistics = Statistics().obs;
  Rx<Youtuber> youtuber = Youtuber().obs;
  @override
  void onInit() async {
    Statistics loadStatistics =
        await YoutubeRepository.to.getVideoInfoById(video.id.videoId);
    statistics(loadStatistics);
    Youtuber loadyoutuber =
        await YoutubeRepository.to.getYoutuberInfoById(video.snippet.channelId);
    youtuber(loadyoutuber);
    super.onInit();
  }

  String get viewCountString =>
      "조회수 ${statistics.value.viewCount ?? '-'}회"; // 안전하게 예외처리

  String get youtuberThumbnailUrl {
    if (youtuber.value.snippet == null) {
      return "https://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png";
    }
    return youtuber.value.snippet.thumbnails.medium.url;
  }
}
