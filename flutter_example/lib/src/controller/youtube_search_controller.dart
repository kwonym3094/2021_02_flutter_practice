import 'package:flutter/material.dart';
import 'package:flutter_example/src/models/youtube_video_result.dart';
import 'package:flutter_example/src/repository/youtube_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YoutubeSearchController extends GetxController {
  String key = "SearchKey";
  RxList<String> history =
      RxList<String>.empty(growable: true); // RxList 초기화하는 방식
  // RxList<String> history = [""].obs; // 이런식으로 해줘도 되지만 자료형을 반드시 리스트안에 표시하기(아니면 다이나믹으로 인식함), 또한 ""이 1개로 보일수도 있음(위 방식 권장)

  // Set<String> originHistory = {};
  SharedPreferences _profs;

  Rx<YoutubeVideoResult> youtubeVideoResult = YoutubeVideoResult(items: []).obs;
  ScrollController scrollController = ScrollController();
  String _currentKeyword;

  void _event() {
    scrollController.addListener(() {
      // print(scrollController.position.pixels); // 스크롤 현재 위치 알기
      print(scrollController.position.maxScrollExtent);
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          youtubeVideoResult.value.nextPageToken != "") {
        _searchYoutube(_currentKeyword);
      }
    });
  }

  @override
  void onInit() async {
    _event();
    _profs = await SharedPreferences.getInstance();
    // String value = (profs.get("ley")) as String; // dynamic으로 들어오기 때문에 String 변환
    List<dynamic> initData = _profs.get(key) ?? [];
    // originHistory.addAll(initData.map((_) => _.toString()).toList());
    // history(originHistory.toList());
    history(initData.map<String>((_) => _.toString()).toList());

    super.onInit();
  }

  void search(String search) {
    // history.clear();
    // originHistory.add(search);
    // history.addAll(originHistory.toList());
    history.addIf(!history.contains(search) && search.length > 0, search);
    // profs.setStringList(key, originHistory.toList());
    _profs.setStringList(key, history);
    _currentKeyword = search;
    _searchYoutube(search);
  }

  void _searchYoutube(String searchKey) async {
    YoutubeVideoResult youtubeVideoResultFromServer = await YoutubeRepository.to
        .search(searchKey, youtubeVideoResult.value.nextPageToken ?? "");

    if (youtubeVideoResultFromServer != null &&
        youtubeVideoResultFromServer.items != null &&
        youtubeVideoResultFromServer.items.length > 0) {
      youtubeVideoResult.update((youtube) {
        youtube.nextPageToken = youtubeVideoResultFromServer.nextPageToken;
        youtube.items.addAll(youtubeVideoResultFromServer
            .items); // 이렇게만 하면 문제 발생 -> nextPageToken 이 업데이트 되지 않음 (초기에 받은 값에는 nextPageToken 값이 없으므로)
      });
    }
  }
}
