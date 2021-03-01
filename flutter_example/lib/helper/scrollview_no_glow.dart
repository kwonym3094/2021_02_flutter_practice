import 'package:flutter/material.dart';

// 최상하단에서 스크롤했을 때 glow 보이는 것 삭제
class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
