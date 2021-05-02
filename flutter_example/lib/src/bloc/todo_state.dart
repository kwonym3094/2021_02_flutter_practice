// state
// bloc 시스템의 가장 핵심적인 부분 : 어떤 상태를 갖고 있는지 알려줌

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/src/models/todo.dart';

@immutable
abstract class TodoState extends Equatable {}

// 아무것도 없는 state
class Empty extends TodoState {
  @override
  List<Object?> get props => [];
}

// 로딩중 state
class Loading extends TodoState {
  @override
  List<Object?> get props => [];
}

// 에러 state
class Error extends TodoState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}

// 로딩완료 결과 있음 state
class Loaded extends TodoState {
  final List<Todo> todos;

  Loaded({required this.todos});

  @override
  List<Object?> get props => [todos];
}
