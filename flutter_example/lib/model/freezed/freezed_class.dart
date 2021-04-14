import 'package:freezed_annotation/freezed_annotation.dart'; // the reason why we import this : to make an object nicely readable in Flutter's devtool.
import 'package:flutter/foundation.dart'; // 2 must-import packages

part 'freezed_class.freezed.dart'; // ~.freezed.dart
part 'freezed_class.g.dart'; // needed if you want to user fromJson()

@freezed // how freezed package recognizes which class to generate an implementation
abstract class User with _$User {
  // const factory User(String name, int age) = _User;
  const factory User(String name, int age) =
      _User; // how to make argument optional
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// Union types -- same as Sealed class in kotlin
// 1. Nested
@freezed
abstract class OperationNested with _$OperationNested {
  const factory OperationNested.add(int value) =
      _Add; // private class => it only can be used OperationNested.add()
  // if we change this to public class, then it can be used as both Add() and OperationNested.add()  and instantiate directly
  const factory OperationNested.subtract(int value) = _Subtract;
}

// 2. Open
@freezed
abstract class Operation with _$Operation {
  const factory Operation.add(int value) = Add;
  const factory Operation.subtract(int value) = Subtract;
}

// open case is recommended if a programmer uses bloc libraries
