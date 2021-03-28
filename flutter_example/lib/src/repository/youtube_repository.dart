import 'package:flutter_example/src/models/statistics.dart';
import 'package:flutter_example/src/models/youtube_video_result.dart';
import 'package:flutter_example/src/models/youtuber.dart';
import 'package:get/get.dart';

class YoutubeRepository extends GetConnect {
  // http 를 하나 감싸는 개념, life cycle 존재
  static YoutubeRepository get to => Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = "https://www.googleapis.com";

    super.onInit();
  }

  Future<YoutubeVideoResult> loadVideos(String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&channelId=UCbMGBIayK26L4VaFrs5jyBw&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyCKxVO5oVHMc9NbvMgiaz-1W6G-eKZSLKw&pageToken=$nextPageToken";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body['items'] != null && response.body["items"].length > 0) {
        print("videos!!!!!!!");
        print(response.body);
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }

  // 조회수 가져오기 : search 에서 다 제공하지 않아서
  Future<Statistics> getVideoInfoById(String videoId) async {
    String url =
        "/youtube/v3/videos?part=statistics&key=AIzaSyCKxVO5oVHMc9NbvMgiaz-1W6G-eKZSLKw&id=$videoId";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body['items'] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        print("statistics!!!!!!!");
        print(data);
        return Statistics.fromJson(data['statistics']);
      }
    }
  }

  Future<Youtuber> getYoutuberInfoById(String channelId) async {
    String url =
        "/youtube/v3/channels?part=statistics,snippet&key=AIzaSyCKxVO5oVHMc9NbvMgiaz-1W6G-eKZSLKw&id=$channelId";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body['items'] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        print("youtuber!!!!!!!");
        print(data);
        return Youtuber.fromJson(data);
      }
    }
  }
}
