import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/helper/helperfunctions.dart';
import 'package:flutter_example/views/chatroom_screen.dart';

import 'helper/authenticate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoggedIn = false;

  @override
  void initState() {
    getLogInState();
    super.initState();
  }

  getLogInState() async {
    await HelperFunctions.getLoggedIn().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff154C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Scaffold : default app 화면
      home:  isLoggedIn ? ChatRoom() : Authenticate(),
    );
  }
}

