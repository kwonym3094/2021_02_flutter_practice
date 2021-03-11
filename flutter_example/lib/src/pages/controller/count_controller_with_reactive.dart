import 'package:get/get.dart';

enum NUM { FIRST, SECOND }

class User {
  String name;
  int age;
  User({this.name, this.age});
}

// reactive 방식의 장점
// 1.값이 변화가 생길 때만 화면 update생김 (위의 print("UPDATE") 참고)
//  즉, 리소스를 덜 사용할 수 있음.
// 2. 이벤트 트리거 할 수 있음 (이 경우에는 GetXController 상속 받아야함)
class CountControllerWithReactive extends GetxController {
  // GetxController 안넣어도됨
  // observable을 만들 수 있음

  RxInt count = 0.obs; // 반응형으로 관리하겠다는 의미. 이전에 get package 포함되있어야함.
  // 여러가지 타입이 있음
  RxDouble float = 0.0.obs;
  RxString value = "".obs;
  // enum 타입은 다음 방식으로
  Rx<NUM> nums = NUM.FIRST.obs;
  // class 는 다음 방식으로
  Rx<User> user = User(name: "테스트", age: 23).obs;
  // List 타입
  RxList<String> list = [""].obs; // 초기값 넣을 때는 자료형 맞춰서 넣어줘야함

  void increase() {
    count++;
    // 업데이트 하는 방법도 여러가지
    float++;
    float(424.1);

    nums(NUM.SECOND);

    user(User());
    user.update((_user) {
      _user.name = "테스트2";
    });

    // list.add(item);
    // list.addAll(item);
    list.addIf(user.value.name == "테스트2", "OKAY"); // 1. 조건, 2. 추가할 값 넣어줌
  }

  void putNumber(int value) {
    // count = value; << 이런 방식이 아니라 다음 방식으로 적용한다는 것 주의
    count(value);
  }

  // 라이프사이클 : 해야할 일이 있으면 정의해주면 됨
  @override
  void onInit() {
    // once
    // ever
    // debounce
    // interval
    ever(count, (_) => print("매번 호출")); // 값이 변경될때마다 호출됨. reactive 상태일때만 가능 !!!
    once(count, (_) => print("한번만 호출됨")); // 최초 한번만 불려지기 때문에 로직반영할려면 새로고침 해줘야함
    debounce(count, (_) => print("마지막에 변경에 한번만 호출"),
        time: Duration(
            seconds:
                1)); // 웹에도 있는 기능, 마지막 반경시 한번만 호출됨. timer를 꼭 설정해줘야함. 검색 기능때 주로 사용함 !
    interval(count, (_) => print("변경되고 있는 동안 설정한 초마다 호출"),
        time: Duration(seconds: 1));
    super.onInit();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // delete는 자동으로 해줌. 나머지만 해주면 됨.

  // @override
  // get onDelete => super.onDelete;
}
