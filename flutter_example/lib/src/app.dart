import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App();

  void printSample() {
    print('avoid_print of lint rule test');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
