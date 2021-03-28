import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YoutubeSearchController extends GetxController {
  @override
  void onInit() {
    SharedPreferences.getInstance();
    super.onInit();
  }
}
