library built_vehicle;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_example/model/serializers.dart';

part 'built_vehicle.g.dart';

abstract class BuiltVehicle
    implements Built<BuiltVehicle, BuiltVehicleBuilder> {
  // fields go here

  VehicleType get type;
  String get brand;
  double get price;
  @nullable
  bool get someNullableValue;
  BuiltList<String> get passengerName;

  BuiltVehicle._();

  factory BuiltVehicle([updates(BuiltVehicleBuilder b)]) = _$BuiltVehicle;

  static Serializer<BuiltVehicle> get serializer =>
      _$builtVehicleSerializer; // helper functions(=fromJson, toJson)도 추가하자 => 새 클래스 만들어서

  // 이상태로는 serialize 할 수 없음 (VehicleType 이라고 자체 정의한 EnumClass 가 있어서) => VehicleType 도 serializer 추가
  String toJson() {
    return json
        .encode(serializers.serializeWith(BuiltVehicle.serializer, this));
  }

  static BuiltVehicle fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltVehicle.serializer, json.decode(jsonString));
  }
}

// enum 사용
class VehicleType extends EnumClass {
  static const VehicleType car = _$car; // 아무거나 적어도 되지만 _$car 으로 적으면서 연습
  static const VehicleType motorbike = _$motorbike;
  static const VehicleType train = _$train;
  static const VehicleType plane = _$plane;

  const VehicleType._(String name)
      : super(name); // enumclass 가 constructor 가 필요함

  // getter for value
  static BuiltSet<VehicleType> get values => _$values;
  static VehicleType valueOf(String name) => _$valueOf(name);

  static Serializer<VehicleType> get serializer => _$vehicleTypeSerializer;
}
