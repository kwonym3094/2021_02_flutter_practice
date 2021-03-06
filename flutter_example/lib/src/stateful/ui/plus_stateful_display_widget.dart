import 'package:flutter/material.dart';
import 'package:flutter_example/src/stateful/components/count_view_stateless.dart';

class PlusStatefulDisplayWidget extends StatefulWidget {
  @override
  _PlusStatefulDisplayWidgetState createState() => _PlusStatefulDisplayWidgetState();
}

class _PlusStatefulDisplayWidgetState extends State<PlusStatefulDisplayWidget> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기본 Stateful'),
      ),
      body: CountViewStateless(count: count),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            count++;
          });
        },
      ),
    );
  }
}
