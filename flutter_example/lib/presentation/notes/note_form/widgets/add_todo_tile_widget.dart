import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_example/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:provider/provider.dart';
import 'package:kt_dart/kt.dart';

import 'package:flutter_example/presentation/notes/note_form/misc/build_context_x.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // BlocBuilder 에서 BlocConsumer로 변경 => BlocBuilder와 BlocListener의 역할을 동시에 해줄수 있음
    return BlocConsumer<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        // 너무 길기 때문에 extension화 해줌 => build_context_x.dart 파일 참고
        // Provider.of<FormTodos>(context, listen: false).value =
        //     state.note.todos.value.fold(
        //         (failure) => listOf<TodoItemPrimitive>(),
        //         (todoItemList) =>
        //             todoItemList.map((_) => TodoItemPrimitive.fromDomain(_)));
        context.formTodos = state.note.todos.value.fold(
            (failure) => listOf<TodoItemPrimitive>(),
            (todoItemList) =>
                todoItemList.map((_) => TodoItemPrimitive.fromDomain(_)));
      },
      buildWhen: (previous, current) =>
          previous.note.todos.isFull != current.note.todos.isFull,
      builder: (context, state) {
        return ListTile(
          enabled: !state.note.todos.isFull,
          title: const Text('Add a todo'),
          leading: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.add),
          ),
          onTap: () {
            // 복잡한 문제가 발생함
            //  - todo item을 추가할 때 사용하는 NoteFormEvent.todosChanged 이벤트를 잘 보면
            //    validated 되지 않은 todo list를 추가한다
            // 다른 위젯들에서도 사용해야하는데 어떻게 해결해야 하는가?
            //  - state를 상위 위젯으로 올리고, provider로 사용하게 해야함
            // context.read<NoteFormBloc>().add(NoteFormEvent.todosChanged(context.read<NoteFormBloc>().state.note.todos),);
            // -todo_item_presentation_classes 와 note_form 확인 해보기

            // 1. formtodo를 불러오고 거기에 새 값을 추가해야함 => ValueNotifier 불러옴
            // Provider.of<FormTodos>(context, listen: false)
            //         .value = // listen: true 이면 build 안에 있는게 아니기 때문에 오류 생김
            //     Provider.of<FormTodos>(context, listen: false)
            //         .value
            //         .plusElement(TodoItemPrimitive.empty());

            // context.read<NoteFormBloc>().add(NoteFormEvent.todosChanged(
            //     Provider.of<FormTodos>(context, listen: false).value));
            // 너무 길기 때문에 extension화 해줌 => build_context_x.dart 파일 참고
            context.formTodos =
                context.formTodos.plusElement(TodoItemPrimitive.empty());
            context.read<NoteFormBloc>().add(NoteFormEvent.todosChanged(
                  context.formTodos,
                ));
          },
        );
      },
    );
  }
}
