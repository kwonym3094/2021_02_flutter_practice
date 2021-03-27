import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/anim/page_slide.dart';
import 'package:flutter_example/views/calendar_page_sample.dart';
import 'package:flutter_example/views/search_page.dart';
import 'package:flutter_example/views/settings_page.dart';
import 'package:flutter_example/views/workout_list_page.dart';
import 'package:flutter_example/widget/tabbar_cupertino_widget.dart';

import 'main_page.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int index = 0;

  final pages = <Widget>[
    MainPage(),
    CalendarSample(),
    // ChartPage(),
    // HeatMapCalendar(),
    SearchPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // actions: [
        //   Row(
        //     children: [
        //       GestureDetector(
        //         child: Container(
        //           padding: EdgeInsets.symmetric(horizontal: 5),
        //           child: Icon(
        //             Icons.search,
        //             color: Colors.black,
        //             size: 30,
        //           ),
        //         ),
        //       ),
        //       GestureDetector(
        //         child: Container(
        //           padding: EdgeInsets.symmetric(horizontal: 5),
        //           child: Icon(
        //             Icons.notifications,
        //             color: Colors.black,
        //             size: 30,
        //           ),
        //         ),
        //       ),
        //     ],
        //   )
        // ],
      ),
      extendBody: true, // floating button 뒤로 contents 보이게 함
      body: pages[index],
      bottomNavigationBar: TabBarCupertinoWidget(
        index: index,
        onChangedTab: onChangedTab,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          _showDialog(context);
        },
        elevation: 0,
        highlightElevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // resizeToAvoidBottomPadding : floating button 이 text 입력시 위로 올라오는 것 방지
      resizeToAvoidBottomInset: false,
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("운동 프로그램 시작"),
        content: SingleChildScrollView(
            child: new Text("오늘 설정하신 운동 프로그램은 ~~~ 입니다. 지금 바로 수행하시겠습니까?")),
        actions: <Widget>[
          new FlatButton(
            child: new Text("시작"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          new FlatButton(
            child: new Text("닫기"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
