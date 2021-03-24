import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_example/src/app.dart';
import 'package:flutter_example/src/binding/init_binding.dart';
import 'package:flutter_example/src/components/youtube_detail.dart';
import 'package:get/get.dart';
=======
import 'package:flutter_example/views/home_page.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'helper/scrollview_no_glow.dart';

>>>>>>> 9ff788d0be118d09f775ec905fd39e936667139a

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
<<<<<<< HEAD
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
        GetPage(name: '/detail/:videoId', page: () => YoutubeDetail()),
      ],
    );
  }
}
=======

  // 플랫폼 판단
  bool get isiOS => foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    if (this.isiOS) {
      return CupertinoApp(
          title: 'Flutter Layout Demo',
          debugShowCheckedModeBanner: false,
          home:Homepage()
      );
    } else {
      return MaterialApp(
        title: 'Flutter Layout Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        builder: (context, child) {
          return ScrollConfiguration(behavior: NoScrollGlow(), child: child);
        },
        home: Homepage()
      );
    }
  }
}




>>>>>>> 9ff788d0be118d09f775ec905fd39e936667139a
