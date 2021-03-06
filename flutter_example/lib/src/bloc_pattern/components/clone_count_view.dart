import 'package:flutter/material.dart';
import 'package:flutter_example/src/bloc_pattern/bloc/count_bloc.dart';

class CloneCountView extends StatelessWidget {

  CountBloc countBloc;

  CloneCountView({Key key, this.countBloc}):super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CountView Build !!");
    return Container(
      child: StreamBuilder(
        stream: countBloc.count, // bloc 패턴에 multi가 되지 않아서 에러
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot){
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
