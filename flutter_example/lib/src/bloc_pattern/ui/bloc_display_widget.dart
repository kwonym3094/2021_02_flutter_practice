import 'package:flutter/material.dart';
import 'package:flutter_example/src/bloc_pattern/bloc/count_bloc.dart';
import 'package:flutter_example/src/bloc_pattern/components/clone_count_view.dart';
import 'package:flutter_example/src/bloc_pattern/components/count_view.dart';


class BlocDisplayWidget extends StatefulWidget {
  BlocDisplayWidget({Key key}) : super(key: key);

  @override
  _BlocDisplayWidgetState createState() => _BlocDisplayWidgetState();
}

class _BlocDisplayWidgetState extends State<BlocDisplayWidget> {
  final CountBloc countBloc = CountBloc();
  @override
  void dispose() {
    super.dispose();
    countBloc.dispose(); // 오류 혹은 메모리 누수를 막기 위해 dispose 해줘야함
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("bloc 패턴"),
      ),
      body: Column(
        children: [
          Expanded(child: CountView(countBloc: countBloc,)),
          Expanded(child: CloneCountView(countBloc : countBloc)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          countBloc.add();
          // countBloc.countEventBloc.countEventSink.add(CountEvent.ADD_EVENT); << 이런식으로도 가능함함
        },
      ),
    );
  }
}
