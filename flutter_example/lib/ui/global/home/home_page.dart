import 'package:flutter/material.dart';
import 'package:flutter_example/ui/global/preference/preference.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PreferencePage()));
              })
        ],
      ),
      body: Center(
        child: Container(
          child: Text(
            'Home',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
