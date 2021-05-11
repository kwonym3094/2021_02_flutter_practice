// 혹시 이상한 값이 들어왔을 때 변경해주는 객체
import 'dart:ui';

// 색깔에 transprency가 있는경우 변경해줌

Color makeColorOpaque(Color color) {
  return color.withOpacity(1);
}
