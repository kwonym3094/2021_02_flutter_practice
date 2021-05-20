import 'package:flutter/cupertino.dart';
import 'package:flutter_example/domain/core/value_objects.dart';
import 'package:flutter_example/domain/notes/todo_item.dart';
import 'package:flutter_example/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

part 'todo_item_presentation_classes.freezed.dart';

// TodoItemDto는 firebase에서 사용하기 위해 자료형을 기본으로 설정해 놓았다.
// Validation 및 Unique ID를 설정해 주기 위해 원형의 자료가 하나 더 필요해서 만듬.

// add_todo_tile 에서 언급한 문제를 풀 방법
class FormTodos extends ValueNotifier<KtList<TodoItemPrimitive>> {
  FormTodos() : super(emptyList<TodoItemPrimitive>());
}
// 해당 ValueNotifier를 상위 위젯에서 사용하게 해줘야함 -> note_form 에서 정의하여 사용

@freezed
abstract class TodoItemPrimitive implements _$TodoItemPrimitive {
  const TodoItemPrimitive._();

  const factory TodoItemPrimitive({
    required UniqueId id,
    required String name,
    required bool done,
  }) = _TodoItemPrimitive;

  factory TodoItemPrimitive.empty() => TodoItemPrimitive(
        id: UniqueId(),
        name: '',
        done: false,
      );

  factory TodoItemPrimitive.fromDomain(TodoItem todoItem) {
    return TodoItemPrimitive(
      id: todoItem.id,
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  TodoItem toDomain() {
    return TodoItem(
      id: id,
      name: TodoName(name),
      done: done,
    );
  }
}
