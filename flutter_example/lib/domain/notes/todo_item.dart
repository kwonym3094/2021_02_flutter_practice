import 'package:dartz/dartz.dart';
import 'package:flutter_example/domain/core/failures.dart';
import 'package:flutter_example/domain/core/value_objects.dart';
import 'package:flutter_example/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_item.freezed.dart';

@freezed
abstract class TodoItem implements _$TodoItem {
// class TodoItem with _$TodoItem {
  // freezed package 에서 getter를 만들기 위해서는 수정이 필요함
  //  - mixin => interface로 변경
  //  - with => implements

  const TodoItem._();

  const factory TodoItem({
    required UniqueId id,
    required TodoName name,
    required bool done,
  }) = _TodoItem;

  // default setting
  factory TodoItem.empty() => TodoItem(
        id: UniqueId(),
        name: TodoName(''),
        done: false,
      );

  // secure validated item
  Option<ValueFailure<dynamic>> get failureOption {
    return name.value.fold((failure) => some(failure), (_) => none());
  }
}
