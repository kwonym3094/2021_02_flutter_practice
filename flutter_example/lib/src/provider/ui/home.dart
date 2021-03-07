import 'package:flutter/material.dart';
import 'package:flutter_example/src/provider/provider/count_provider.dart';
import 'package:provider/provider.dart';

import 'count_home_widget.dart';

// provider 를 사용하면 stateful widget으로 사용해야할 일이 거의 없다
// 허나 setState 로 사용해야할 경우도 생기니 주의

// provider 패턴으로 정보를 가져갈려면 provider 로 감싸줘야함

class Home extends StatelessWidget {
  /*
  * 3. provider를 불러오는 방법
  * Provider.of<생성한 프로바이더>(context);
  * */
  CountProvider _countProvider;

  @override
  Widget build(BuildContext context) {
    _countProvider = Provider.of<CountProvider>(context, listen: false); // listen : false => 부모 등록 방법, 필요에 따라 필요할 수도, 필요없을 수도 있음
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Pattern'),
      ),
      body: CountHomeWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _countProvider.add()),
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => _countProvider.remove()),
        ],

      )
    );
  }
}
