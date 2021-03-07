import 'package:flutter/cupertino.dart';

class CountProvider extends ChangeNotifier {

  int _count = 0;

  int get count => _count;

  add() {
    _count++;
    // 4. 변경됬다는 신호 보내주기 : notifyListeners();
    notifyListeners();
  }

  remove() {
    _count--;
    notifyListeners();
  }

}