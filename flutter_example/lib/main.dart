import 'package:flutter/material.dart';
import 'package:flutter_example/ui/ui.dart';
import 'package:flutter_example/viewmodel/viewmodel.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      home:
      ChangeNotifierProvider(
        create: (context) => MovieListViewModel(),
        child: MovieListPage(),
      ),

    );
  }
}

