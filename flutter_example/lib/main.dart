import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/src/app.dart';
import 'package:flutter_example/src/binding/init_binding.dart';
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
          accentColor: Colors.black,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => App()),
      ],
      initialBinding: InitBinding(),
    );
  }
}
