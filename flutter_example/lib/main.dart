import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/src/app.dart';
import 'package:flutter_example/src/binding/init_binding.dart';
import 'package:flutter_example/src/components/youtube_detail.dart';
import 'package:flutter_example/src/cotroller/youtube_detail_controller.dart';
import 'package:flutter_example/src/cotroller/youtube_search_controller.dart';
import 'package:flutter_example/src/pages/search.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Youtube Clone Coding",
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      initialBinding: InitBinding(),
      getPages: [
        GetPage(name: '/', page: () => App()),
        GetPage(
          name: '/detail/:videoId',
          page: () => YoutubeDetail(),
          binding: BindingsBuilder(
            () => Get.lazyPut<YoutubeDetailController>(
              () => YoutubeDetailController(),
            ),
          ),
        ),
        GetPage(
          name: '/search',
          page: () => YoutubeSearch(),
          binding: BindingsBuilder(
            () => Get.lazyPut<YoutubeSearchController>(
              () => YoutubeSearchController(),
            ),
          ),
        ),
      ],
    );
  }
}
