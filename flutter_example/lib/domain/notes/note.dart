// Entity

import 'package:dartz/dartz.dart';
import 'package:flutter_example/domain/core/failures.dart';
import 'package:flutter_example/domain/core/value_objects.dart';
import 'package:flutter_example/domain/notes/todo_item.dart';
import 'package:flutter_example/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

part 'note.freezed.dart';

@freezed
abstract class Note implements _$Note {
  const Note._();

  const factory Note({
    required UniqueId id,
    required NoteBody body,
    required NoteColor color,
    required List3<TodoItem> todos,
  }) = _Note;

  // helper factory
  //  - default note
  factory Note.empty() => Note(
        id: UniqueId(),
        body: NoteBody(''),
        color: NoteColor(NoteColor.predefinedColors[0]),
        todos: List3(emptyList()),
      );

  // secure validated item
  Option<ValueFailure<dynamic>> get failureOption {
    // 1차 validation : body가 failure 값이 아닌지
    return body.failureOrUnit
        // 2차 validation : todos 전체가 failure 값이 아닌지(여기서는 리스트 크기)
        .andThen(todos.failureOrUnit)
        // 3차 validation : todos 리스트 안의 아이템이 failure 값이 아닌지
        .andThen(
          todos
              // error가 생겼나? => 위에서 처리했기 때문에 무조건 통과할 것임
              .getOrCrash()
              // 그렇다면 각각의 아이템이 error 인가?
              .map((todoItem) => todoItem.failureOption)
              // list의 where과 같음. 즉, 리스트 아이템 하나하나씩 비교하면서 고름
              .filter((option) => option.isSome())
              // 만약 index 0을 가지지 않는다면
              //  - index 0 의미 : 요소가 존재하지 않음
              .getOrElse(0, (_) => none())
              // 만약 index 0을 가지지 않는다면
              //  - index 0 의미 : 요소가 존재하지 않음
              .fold(
                  () => right(unit), // left 의미 : 모두 valid 한 값이 들어있음
                  (failure) =>
                      left(failure) // right의 의미: 하나라도 invalid 한 값이 들어있음.
                  ),
        )
        .fold((failure) => some(failure), (_) => none());
  }
}
