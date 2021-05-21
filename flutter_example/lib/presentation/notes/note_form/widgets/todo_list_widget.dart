import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kt_dart/collection.dart';
import 'package:provider/provider.dart';

import 'package:flutter_example/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_example/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';

// 직접 import 해줘야함
import 'package:flutter_example/presentation/notes/note_form/misc/build_context_x.dart';

// 3개 이상 Todo를 추가하는 snackbar는 이곳에 추가해도 되고, add-todo에 추가해도 됨
class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.note.todos.isFull != current.note.todos.isFull,
      listener: (context, state) async {
        if (state.note.todos.isFull) {
          await showFlash(
              context: context,
              duration: const Duration(seconds: 4),
              builder: (context, controller) => Flash.bar(
                    controller: controller,
                    backgroundColor: Colors.grey.withOpacity(0.8),
                    margin: const EdgeInsets.all(8.0),
                    position: FlashPosition.bottom,
                    enableVerticalDrag: true,
                    horizontalDismissDirection:
                        HorizontalDismissDirection.horizontal,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    forwardAnimationCurve: Curves.easeOutBack,
                    reverseAnimationCurve: Curves.easeOutBack,
                    child: FlashBar(
                      content:
                          const Text('Want longer lists? Activate Premium! 😏'),
                      actions: const [
                        Text(
                          'BUY NOW',
                          style: TextStyle(color: Colors.blue),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  ));
        }
      },
      child: Consumer<FormTodos>(
        builder: (context, formTodos, child) {
          return ListView.builder(
            // shirinkWrap : ListView는 원래 vertically unbound, child 사이즈에 맞춰서 줄여주는것이 shirinkWrap
            // 짧은 list의 경우 상관없지만, list가 길어지게 되면 performance 문제가 생길 수 있으니 주의(현재 scrollview 아래 listview가 있기 때문에)
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return TodoTile(
                index: index,
              );
            },
            itemCount: formTodos.value.size,
          );
        },
      ),
    );
  }
}

class TodoTile extends HookWidget {
  final int index;

  const TodoTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getOrElse는 ktlist안에 있음 => import 한다음에 사용
    final todo = context.formTodos.getOrElse(
      index,
      (_) => TodoItemPrimitive.empty(),
    );

    return ListTile(
      leading: Checkbox(
        value: todo.done,
        onChanged: (value) {
          // primitive에 먼저 넣고
          // 그다음에 application의 bloc 에 넣고 state를 바꿔줌
          // 아래서 mapping 하는 이유? 하나 todo item만 업데이트 할때
          context.formTodos = context.formTodos.map(
            (listTodo) =>
                listTodo == todo ? todo.copyWith(done: value!) : listTodo,
          );
          // KtList는 immutable 하기 때문에 요소를 바꿀 수 없고, 전체를 바꿔야하기 때문에 위 같은 조치를 함

          context
              .read<NoteFormBloc>()
              .add(NoteFormEvent.todosChanged(context.formTodos));
        },
      ),
    );
  }
}
