import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListView(
        children: [
          Center(child: Text('test1', style: TextStyle(fontSize: 12,),),),
          Center(child: Text('test1', style: TextStyle(fontSize: 12,),),),
          Center(child: Text('test1', style: TextStyle(fontSize: 12,),),),
        ],
      )
    );
  }
}
