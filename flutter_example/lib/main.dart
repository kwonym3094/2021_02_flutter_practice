import 'package:flutter/material.dart';
import 'package:flutter_example/src/provider/provider/count_provider.dart';
import 'package:flutter_example/src/provider/ui/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

/*
* 2. MyApp 에서도 provider 에 접근을 해야한다면
* MyApp 바깥에서 적용해주기
* */
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (BuildContext context) => CountProvider(),
//       child: MyApp(),
//     ),
//   );
// }


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
      home: ChangeNotifierProvider( // 해당 provider 은 single provider => 여러개의 상태관리를 해줘야하는 앱에서는 multi provider 로 관리 해야함 => provider_practice branch 에서 사용
        create: (BuildContext context) => CountProvider(),
        child: Home(),
      ),
    );
  }
}


