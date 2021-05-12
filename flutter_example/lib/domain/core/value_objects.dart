// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:flutter_example/domain/core/errors.dart';
import 'failures.dart';

// @immutable: final field만 존재하게 강요함
@immutable
abstract class ValueObject<T> {
  // 모든 value object 가 string 을 가질 필요가 없으므로 generic으로 바꿈
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    return value.fold(
        // (failure) => throw UnExpectedValueError(failure), (success) => success); // self-explanatory => identity로 변경
        (failure) => throw UnExpectedValueError(failure),
        id); // ctrl + click 눌러서 dartz 패키지 참고
    // id = identity - same as writing (right) => right
  }

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold((failure) => left(failure), (r) => right(unit));
  }

  bool isValid() => value.isRight();

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

// 각각 객체(ex. User, Note)에 대해 유일한 id를 가지도록 만들 value object가 필요함
class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  // 앱 자체에서 unique한 값을 생성해야 할 때 => 패키지 사용(uuid)
  factory UniqueId() {
    return UniqueId._(right(const Uuid().v1()));
  }

  // 이미 unique 한 값을 받았을 때(ex. email id)
  factory UniqueId.fromUniqueString(String uniqueId) {
    assert(uniqueId != null);
    return UniqueId._(
      right(uniqueId),
    );
  }

  const UniqueId._(this.value);
}
