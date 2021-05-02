// bloc logic 부분
// 1. cubit, 2. bloc 두가지가 있음.
// - bloc이 코드가 좀 더 많이 들어감
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/src/bloc/todo_event.dart';
import 'package:flutter_example/src/bloc/todo_state.dart';
import 'package:flutter_example/src/models/todo.dart';
import 'package:flutter_example/src/repository/todo_repository.dart';

// Bloc class는 generic 2개를 받음 => Bloc<Event, State>
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // Dependency Injection
  final TodoRepository repository;
  // final TodoRepository repository = TodoRepository(); 하면 되지 않는가? => TDD 원칙에 위배됨 => 테스트 하기 힘들어짐

  // 필수적으로 생성해야되는 컨스트럭터
  TodoBloc({required this.repository})
      : super(Empty()); // 기본 state가 들어가야함 : 여기서는 Empty state

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    // Stream은 async*
    // 모든 이벤트 들이 이 함수를 통해서 실행되게 됨

    // 제일 먼저 해야할 일 : 들어온 이벤트가 어떤 이벤트인지 알아내야 함
    if (event is ListTodoEvent) {
      yield* _mapListTodosEvent(event); // yield : async*에서 사용할 수 있음
    } else if (event is CreateTodoEvent) {
      yield* _mapCreateTodoEvent(event);
    } else if (event is DeleteTodoEvent) {
      yield* _mapDeleteTodoEvent(event);
    }
  }

  // * 중요 *
  //  - UI와 가장 먼저 맞닥드리는 로직
  //  - UI에서 에러가 나는 것을 최소화 시켜줘야함 !!!
  //     => 1. try catch 문으로 우선 에러 처리 (여기선 TodoEvent의 Error 만 처리 했음)
  Stream<TodoState> _mapListTodosEvent(ListTodoEvent event) async* {
    try {
      // 데이터 오기 전까지 Loading 상태로 보여주고
      yield Loading();
      // REST API로 데이터 가져오고
      final resp = await repository.listTodo();
      // 데이터 받은 것을 할당하여
      final todos = resp.map<Todo>((e) => Todo.fromJson(e)).toList();
      // Loaded 상태로 변경
      yield Loaded(todos: todos);
    } catch (e) {
      yield Error(message: e.toString());
    }
  }

  // logics of create method are different
  Stream<TodoState> _mapCreateTodoEvent(CreateTodoEvent event) async* {
    try {
      // existing data need to be imported
      // final parsedState = state; // prove

      if (state is Loaded) {
        final parsedState = (state as Loaded);

        final newTodo = Todo(
            id: parsedState.todos[parsedState.todos.length - 1].id + 1,
            title: event.title,
            createdAt: DateTime.now().toString());

        // wanna to send UI the inserted data in advance as if it is already loaded.

        final prevTodos = [
          ...parsedState.todos,
        ];

        // fake todos : it needs to be updated when backend responds

        final newTodos = [
          ...prevTodos,
          newTodo,
        ];

        yield Loaded(todos: newTodos);

        final resp = await repository.createTodo(newTodo);

        yield Loaded(todos: [
          ...prevTodos,
          Todo.fromJson(resp),
        ]);
      }
    } catch (e) {
      yield Error(message: e.toString());
    }
  }

  Stream<TodoState> _mapDeleteTodoEvent(DeleteTodoEvent event) async* {
    try {
      if (state is Loaded) {
        final newTodos = (state as Loaded)
            .todos
            .where((todo) => todo.id != event.todo.id)
            .toList();

        yield Loaded(todos: newTodos);

        await repository.deleteTodo(event.todo);
      }
    } catch (e) {
      yield Error(message: e.toString());
    }
  }
}
