import 'dart:async';

class CountBloc {
  int _count = 0;
  final StreamController<int> _countSubject = StreamController<int>.broadcast(); // 여러 개에서 구독 할 때는 broadcast를 꼭 해줘야함
  Stream<int> get count => _countSubject.stream;

  add() {
    _count++;
    _countSubject.sink.add(_count);
  }

  dispose() {
    _countSubject.close();
  }
}