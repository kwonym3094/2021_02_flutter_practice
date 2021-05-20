// DTO(Data Transfer Object)

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_example/domain/core/value_objects.dart';
import 'package:flutter_example/domain/notes/note.dart';
import 'package:flutter_example/domain/notes/todo_item.dart';
import 'package:flutter_example/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

part 'note_dtos.freezed.dart';
part 'note_dtos.g.dart'; // DTO를 JSON 으로 변환하기 위해서 작성

@freezed
abstract class NoteDto implements _$NoteDto {
  const NoteDto._();

  const factory NoteDto({
    @JsonKey(ignore: true) String? id,
    required String body,
    required int color,
    required List<TodoItemDto> todos,
    // 나중에 바꿔야할 값 : firebase의 서버 시간을 따라감
    required dynamic serverTimeStamp,
  }) = _NoteDto;

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
      id: note.id.getOrCrash(),
      body: note.body.getOrCrash(),
      color: note.color.getOrCrash().value,
      todos: note.todos
          .getOrCrash()
          .map(
            (todoItem) => TodoItemDto.fromDomain(todoItem),
          )
          .asList(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  Note toDomain() {
    return Note(
      id: UniqueId.fromUniqueString(id),
      body: NoteBody(body),
      color: NoteColor(Color(color)),
      todos: List3(todos.map((dto) => dto.toDomain()).toImmutableList()),
    );
  }

  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);

  // firestore을 사용하기 때문에 firestore id가 필요함
  //  - json에 같이 담겨서 오는것이 아니기 때문에 따로 받아줘야함
  factory NoteDto.fromFirestore(DocumentSnapshot doc) {
    return NoteDto.fromJson(doc.data()! as Map<String, dynamic>)
        .copyWith(id: doc.id);
  }
}

// json serializer가 FieldValue(=3rd party library object)를 인식하지 못하기 때문에 converter 가 필요함
class ServerTimeStampConverter implements JsonConverter<FieldValue, Object> {
  // 사용할 수 있도록 annotation화 해야함 (dart 에서 annotation화 할때 const 로 정의해줘야하는 것 주의)
  const ServerTimeStampConverter();

  // JSON -> DTO 에 넣을때
  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  // 중요!
  // DTO -> JSON 으로 만들 때
  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}

@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  const TodoItemDto._();

  const factory TodoItemDto({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDto;

  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
      id: todoItem.id.getOrCrash(),
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  TodoItem toDomain() {
    return TodoItem(
      id: UniqueId.fromUniqueString(id),
      name: TodoName(name),
      done: done,
    );
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);
}
