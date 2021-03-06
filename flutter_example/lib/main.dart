import 'package:flutter/material.dart';
import 'package:flutter_example/src/bloc_pattern/ui/bloc_display_widget.dart';
import 'package:flutter_example/src/stateful/ui/plus_stateful_display_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('bloc pattern'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return BlocDisplayWidget();
                }));
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Text("bloc 패턴",
                  style: TextStyle(fontSize: 30),),
                )
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return PlusStatefulDisplayWidget();
                }));
              },
              child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Text("기본 stateful",
                      style: TextStyle(fontSize: 30),),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}


