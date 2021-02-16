import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/page/chart_page.dart';
import 'package:flutter_example/page/main_page.dart';
import 'package:flutter_example/page/search_page.dart';
import 'package:flutter_example/page/settings_page.dart';
import 'package:flutter_example/widget/tabbar_cupertino_widget.dart';
import 'package:flutter_example/widget/tabbar_material_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Layout Demo',
        home: PageChanger()
    );
  }
}

class PageChanger extends StatefulWidget {
  @override
  _PageChangerState createState() => _PageChangerState();
}

class _PageChangerState extends State<PageChanger> {

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
        onPressed: () => print('test'),
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

