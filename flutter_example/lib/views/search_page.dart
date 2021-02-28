import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/widget/content_list_widget.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        SearchBar(context),
      ],
    );
  }
}

Widget SearchBar(BuildContext context) {

  TextEditingController _textEditingController = TextEditingController();


  return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.grey[350], borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width - 60,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: Icon(
                  Icons.search,
                  size: 20,
                ),
              ),
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                  hintText: "검색어를 입력하세요",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
                    controller: _textEditingController,
              )),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            child: Container(
              width: 30,
                child: Text('취소')
            )
        )
      ]
  );
}
