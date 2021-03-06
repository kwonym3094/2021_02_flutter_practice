
// BLOC 정석의 패턴
import 'dart:async';

class CountBloc2 {
  CountEventBloc2 countEventBloc2 = CountEventBloc2();
  int _count = 0;
  final StreamController<int> _countSubject = StreamController<int>();
  Stream<int> get count => _countSubject.stream; // 6. stream 을 구독하고 있는 widget 에 변경된 값을 전달하게 됨

  // 1. 생성할때 생성자 호출
  CountBloc2(){
    countEventBloc2._countEventSubject.stream.listen(_countEventListen); // 2. CountEventBloc2를 구독하고 있음 // 4. 구독자에게 listen을 보내주는데 이는 함수
  }

  _countEventListen(CountEvent2 event){ // 5. 4번에서 받은 함수
    // 6. 비즈니스 로직 부분
    switch (event) {
      case CountEvent2.ADD_EVENT :
        _count++;
        break;
      case CountEvent2.SUBTRACT_EVENT :
        _count--;
        break;
    }
    _countSubject.sink.add(_count); // 7. sink 에 값을 넣어줌
  }

  dispose() {
    _countSubject.close();
    countEventBloc2.dispose();
  }
}

class CountEventBloc2 {
  final StreamController<CountEvent2> _countEventSubject = StreamController<CountEvent2>();

  Sink<CountEvent2> get countEventSink => _countEventSubject.sink; // 3. Event 값이 sink 로 들어오면 (변화가 생기면) 구독자(=_countEventSubject) 에게 알려줌 (2번 참고)

  dispose() {
    _countEventSubject.close();
  }
}

enum CountEvent2 { ADD_EVENT, SUBTRACT_EVENT }