// flutter_bloc 라이브러리에서 bloc이 아닌 다른 패턴
//  - 기존 bloc 보다 쉬운 버전이라 생각하면 쉬움

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/src/bloc/todo_state.dart';
import 'package:flutter_example/src/models/todo.dart';
import 'package:flutter_example/src/repository/todo_repository.dart';

class TodoCubit extends Cubit<TodoState> {
  // state 만 넣으면 됨

// D.I.
  final TodoRepository repository;

  TodoCubit({required this.repository}) : super(Empty());

  // mapEventToState 를 override 받는 것이 없음 => Getx 처럼 그냥 정의만 해주고 사용하면 됨
  listTodo() async {
    try {
      emit(Loading()); // Stream 의 yield 와 같음

      final resp = await repository.listTodo();
      final todos = resp.map<Todo>((e) => Todo.fromJson(e)).toList();

      emit(Loaded(todos: todos));
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  createTodo(String title) async {
    try {
      if (state is Loaded) {
        final parsedState = (state as Loaded);

        final newTodo = Todo(
            id: parsedState.todos[parsedState.todos.length - 1].id + 1,
            title: title,
            createdAt: DateTime.now().toString());

        final prevTodos = [
          ...parsedState.todos,
        ];

        final newTodos = [
          ...prevTodos,
          newTodo,
        ];

        emit(Loaded(todos: newTodos));

        final resp = await repository.createTodo(newTodo);

        emit(Loaded(todos: [...prevTodos, Todo.fromJson(resp)]));
      }
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }

  deletTodo(Todo todo) async {
    try {
      if (state is Loaded) {
        final newTodos = (state as Loaded)
            .todos
            .where((item) => item.id != todo.id)
            .toList();

        emit(Loaded(todos: newTodos));

        await repository.deleteTodo(todo);
      }
    } catch (e) {
      emit(Error(message: e.toString()));
    }
  }
}
