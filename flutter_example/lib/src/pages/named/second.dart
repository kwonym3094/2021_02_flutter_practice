import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondNamedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Named Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("뒤로 이동"),
              onPressed: () {
                // 1.뒤로가기 기존
                // Navigator.of(context).pop();
                // 2. getX 뒤로가기
                Get.back();
              },
            ),
            RaisedButton(
              child: Text("홈으로 이동"),
              onPressed: () {
                // 1. 기존방식
                /**
                 * Navigator.of(context).pushAndRemoveUntil(
                 *   MaterialPageRoute(builder: (_) => Home()),
                 *   (route) => false);
                 */

                // 2. GetX 방식
                // 한번 봤다가 다시 돌아갈 이유가 없는 페이지를 이렇게 사용
                // 회원가입 같은 경우
                Get.offAllNamed('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
