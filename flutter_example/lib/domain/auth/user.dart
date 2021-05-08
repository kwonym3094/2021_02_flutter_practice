// ValueObject를 상속하지 않을것임 => 대신 entity
// 필요한 것 : Unique ID
// domain 에 entity를 따로 만들면서 infrastructure에 독립된 상황을 만들 수 있음

import 'package:flutter_example/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  // 어떻게 유일한 id 를 만들지?
  const factory User({
    required UniqueId id,
  }) = _User;
}
