import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/anim/page_slide.dart';
import 'package:flutter_example/views/search_page.dart';
import 'package:flutter_example/views/settings_page.dart';
import 'package:flutter_example/views/workout_list_page.dart';
import 'package:flutter_example/widget/tabbar_cupertino_widget.dart';

import 'chart_page.dart';
import 'main_page.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int index = 0;

  final pages = <Widget>[
    MainPage(),
    SearchPage(),
    ChartPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // floating button 뒤로 contents 보이게 함
      body: pages[index],
      bottomNavigationBar: TabBarCupertinoWidget(
        index : index,
        onChangedTab : onChangedTab,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () => Navigator.of(context).push<void>(createRoute(MyListPage())),
        elevation: 0,
        highlightElevation: 0,
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
    );
  }

  void onChangedTab(int index){
    setState(() {
      this.index = index;
    });
  }
}