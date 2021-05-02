// flutter bloc 은 1. cubit, 2. bloc 를 사용할 수 있음
// cubit을 쓸때는 event 필요 없음
// bloc 을 쓸때는 event 필요함

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/src/models/todo.dart';

// 99% rest api 개수와 같이 만들어주면 됨

@immutable
abstract class TodoEvent extends Equatable {}

class ListTodoEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class CreateTodoEvent extends TodoEvent {
  // - todo_repository.dart 참조
  //   - Create REST API는 인자로 Todo instance를 갖고 있어야함 => 처리 해줘야함
  final String title;

  CreateTodoEvent({required this.title});

  @override
  List<Object?> get props => [title];
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  DeleteTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}
