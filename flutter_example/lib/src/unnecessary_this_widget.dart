import 'package:flutter/material.dart';

class UnnecessaryThisWidget extends StatelessWidget {
  UnnecessaryThisWidget();
  String name = 'UnnecessaryThisWidget';

  void changeName(String name) {
    this.name = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.name),
      ),
    );
  }
}
