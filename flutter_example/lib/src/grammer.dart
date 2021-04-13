void run() {
  const constVar = 'hello world!';
  final finalVar = 'hello world!';

  // const notWorking = finalVar; // const 에는 final 할당할 수 없고
  const working = constVar; // const에 const는 할당할 수 있음

  const x = MyConstants(constVar, ["123", "456"]);
  // final x = MyConstants(constVar, ["123", "456"]); // class의 데이터 타입이 const가 아니라 new 로 뜨는 것이 보인다 => 사용자가 정의할 때 데이터 타입이 정해짐
  // const y = MyConstants(finalVar, ["123", "456"]); // const 에 final 할당 불가

  // final implicitNew = MyWannabeConstants(Future.value(1234));
  // final explicitNew = new MyWannabeConstants(Future.value(1234));

  // const implicitConst = MyWannabeConstants(Future.value(1234)); // 정의하는 부분에서 Future이 const가 아니기 때문에 에러가 발생함
  // const ExplicitConst = const MyWannabeConstants(Future.value(1234));
}

class MyConstants {
  final String field1;
  final List<String> field2;

  const MyConstants(this.field1, this.field2);
}

class MyWannabeConstants {
  // Future은 const가 아닌데 왜 정의에서 에러가 뜨지 않는 것인가 => const class가 사용자가 정의할 때 만들어 지기 때문에?
  // 위 확인
  final Future<int> field;

  const MyWannabeConstants(this.field);
}
