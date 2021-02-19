import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/widget/content_list_widget.dart';
import 'package:flutter_example/widget/search_bar.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  // 데이터를 정리하고 받아오는 공간으로 사용
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50,),
          // Search Bar
          SearchBar(),
          SizedBox(height: 30,)


        ],
      ),
    );
  }


}

