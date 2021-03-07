import 'package:flutter/material.dart';
import 'package:flutter_example/src/provider/provider/bottom_navigation_provider.dart';
import 'package:flutter_example/src/provider/provider/count_provider.dart';
import 'package:flutter_example/src/provider/provider/movie_provider.dart';
import 'package:flutter_example/src/provider/ui/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      /*
      * 1.
      * provider를 사용하기 위해 전체 위젯을 ChangeNotifierProvider 로 감싸줌
        create, child 두 개 params 를 상속 받음
        child 에 기존 UI 삽입
        create 에 ChangeNotifier 상속받은 widget 삽입
      *
      * */
      home: MultiProvider(
        // Multi 로 등록할 수 있게 변경
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => CountProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => BottomNavigationProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => MovieProvider()),
        ],
        child: Home(),
      ),
    );
  }
}
