// ValueObject를 상속하지 않을것임 => 대신 entity (이미 검증을 거치고 나온 값이기 때문에 validation 이 필요 없기 때문)
// 이 User은 다양한 DB(ex. SQLite, Hive, Firestore)에 독립적으로 사용될 것 => Unique id 만 필요
// 필요한 것 : Unique ID
// domain 에 entity를 따로 만들면서 infrastructure에 독립된 상황을 만들 수 있음

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:flutter_example/domain/core/value_objects.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  // 어떻게 유일한 id 를 만들지?
  const factory User({
    required UniqueId id,
  }) = _User;
}
