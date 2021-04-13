import 'package:flutter_example/model/built_vehicle.dart';

class CodeRunner {
  static void runCode() {
    var car = BuiltVehicle((b) => b
      ..type = VehicleType.car
      ..brand = 'Tesla'
      ..price = 1000000
      ..passengerName.addAll([
        'John',
        'Sophia',
        'Dave'
      ])); // cascade operator : .. => 하나의 object에 함수호출, 필드접근을 순차적으로 수행할 수 있음. 과정중간에 어떤값이 반환되더라도 무시.

    print(car);

    // copy BuiltVehicle
    var copiedTrain = car.rebuild((b) => b
      ..brand = 'Skoda Transportation'
      ..type = VehicleType.train);
    print(copiedTrain); // rebuild 했을 때 car 자체를 바꾸지 않고 새 instance를 반환했다는 것 주목

    // // 만약 같은 instance를 만들면 ? immutability 확인
    // var car2 = BuiltVehicle((b) => b
    //   ..type = 'car'
    //   ..brand = 'Tesla'
    //   ..price = 1000000);

    // print(car == car2); // true

    // // 만약 일부가 다 안채워졌다면?

    // var car3 = BuiltVehicle((b) => b
    //   ..type = 'car'
    //   ..price = 1000000);

    // print(car3); // 에러 발생 => null 허용하고 싶으면 field 자체에 @nullable annotation 추가

    // collection은 어떻게 추가하나? => BuiltList (built_collection.dart 에 있음)

    // built_value 라이브러리 중요 기능 : Serialization => class에 Serilizer<built_value_class> 작성!

    final carJson = car.toJson();
    print(
        carJson); // 결과 찍으면 예상과 다르게 list 형태로 나옴 => built_value 라이브러리 자체 serializer라서 그런듯 => serializers 에 plugin 추가해서 처리해줌

    final carFromJson =
        BuiltVehicle.fromJson(carJson).rebuild((b) => b..price = 2000);
    print(carFromJson);
  }
}
