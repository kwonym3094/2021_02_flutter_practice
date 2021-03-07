import 'package:flutter/material.dart';
import 'package:flutter_example/src/provider/components/view_count_widget.dart';
import 'package:flutter_example/src/provider/provider/count_provider.dart';
import 'package:provider/provider.dart';

class CountHomeWidget extends StatelessWidget {
  CountProvider _countProvider;

  @override
  Widget build(BuildContext context) {
    print("CountHome Build");
    /*
    * 5. 이 상태로만 마무리하면 전체가 계속 빌드 되는 현상이 발생함
    * 그러지 않길 원한다면 consumer를 사용
    * builder는 context, provider, child 3개를 받음
    * 부모에서도 add 를 사용하니까 등록해줘야함
    * */

    _countProvider = Provider.of<CountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Count Provider'),
      ),
      body: ViewCountWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              icon: Icon(Icons.add), onPressed: () => _countProvider.add()),
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => _countProvider.remove()),
        ],
      ),
    );
  }
}
