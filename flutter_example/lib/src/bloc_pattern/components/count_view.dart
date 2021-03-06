import 'package:flutter/material.dart';
import 'package:flutter_example/src/bloc_pattern/bloc/count_bloc.dart';

class CountView extends StatelessWidget {
  CountBloc countBloc;

  CountView({Key key, this.countBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CountView Build !!");
    return Center(
      child: StreamBuilder(
        stream: countBloc.count,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) { // 8. count값을 snapshot으로 넣어줌
          if (snapshot.hasData) {
            return Text(
              snapshot.data.toString(),
              style: TextStyle(fontSize: 80),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}