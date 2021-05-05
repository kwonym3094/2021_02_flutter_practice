import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'failures.dart';

// @immutable: final field만 존재하게 강요함
@immutable
abstract class ValueObject<T> {
  // 모든 value object 가 string 을 가질 필요가 없으므로 generic으로 바꿈
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
