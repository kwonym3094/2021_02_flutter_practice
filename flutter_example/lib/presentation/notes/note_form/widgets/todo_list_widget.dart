import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:kt_dart/collection.dart';
import 'package:provider/provider.dart';

import 'package:flutter_example/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_example/domain/notes/value_objects.dart';
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
          // return ListView.builder(
          //   // shirinkWrap : ListView는 원래 vertically unbound, child 사이즈에 맞춰서 줄여주는것이 shirinkWrap
          //   // 짧은 list의 경우 상관없지만, list가 길어지게 되면 performance 문제가 생길 수 있으니 주의(현재 scrollview 아래 listview가 있기 때문에)
          //   shrinkWrap: true,
          //   itemBuilder: (context, index) {
          //     return TodoTile(
          //       index: index,
          //       key: ValueKey(context.formTodos[index].id),
          //     );
          //   },
          //   itemCount: formTodos.value.size,
          // );
          return ImplicitlyAnimatedReorderableList<TodoItemPrimitive>(
            shrinkWrap: true,
            removeDuration: const Duration(milliseconds: 0),
            items: formTodos.value.asList(),
            areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
            onReorderFinished: (item, from, to, newItems) {
              context.formTodos = newItems.toImmutableList();
              context
                  .read<NoteFormBloc>()
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
            itemBuilder: (context, itemAnimation, item, index) {
              return Reorderable(
                key: ValueKey(item.id),
                builder: (context, dragAnimation, inDrag) {
                  // handle은 reorderable 가능하게 해주는 handler
                  // Handle(child: child)

                  return ScaleTransition(
                    // 움직일 때 scale 변화 효과 추가
                    // in usual : 0 to 1
                    // this case : 1 to 0.95
                    scale: Tween<double>(begin: 1, end: 0.95)
                        .animate(dragAnimation),
                    child: TodoTile(
                      index: index,
                      elevation: dragAnimation.value * 4,
                    ),
                  );
                },
              );
            },
            // delete 했을 때 사라지는 것이 매우 어색함
            // removeItemBuilder: (context, animation, item) {},
          );
          // areItemsTheSame: areItemsTheSame, onReorderFinished: onReorderFinished)
        },
      ),
    );
  }
}

class TodoTile extends HookWidget {
  final int index;
  final double? elevation;

  const TodoTile({
    Key? key,
    required this.index,
    double? elevation,
  })  : elevation = elevation ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // getOrElse는 ktlist안에 있음 => import 한다음에 사용
    final todo = context.formTodos.getOrElse(
      index,
      (_) => TodoItemPrimitive.empty(),
    );
    // Hook를 이용하여 TextEditingController을 가져올 수 있음
    final textEditingController = useTextEditingController(text: todo.name);

    return Slidable(
      // drawer effect 지정해줘야함
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          color: Colors.red,
          onTap: () {
            context.formTodos = context.formTodos.minusElement(todo);
            // minusElement : 요소 빼기
            context
                .read<NoteFormBloc>()
                .add(NoteFormEvent.todosChanged(context.formTodos));
            // 이렇게만 하면 이상한 것이 삭제 된다 => 유일성을 구분하기 위해 key가 필요함
          },
        )
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Material(
          elevation: elevation!,
          animationDuration: const Duration(milliseconds: 50),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              leading: Checkbox(
                value: todo.done,
                onChanged: (value) {
                  // primitive에 먼저 넣고
                  // 그다음에 application의 bloc 에 넣고 state를 바꿔줌
                  // 아래서 mapping 하는 이유? 하나 todo item만 업데이트 할때
                  context.formTodos = context.formTodos.map(
                    (listTodo) => listTodo == todo
                        ? todo.copyWith(done: value!)
                        : listTodo,
                  );
                  // KtList는 immutable 하기 때문에 요소를 바꿀 수 없고, 전체를 바꿔야하기 때문에 위 같은 조치를 함

                  context
                      .read<NoteFormBloc>()
                      .add(NoteFormEvent.todosChanged(context.formTodos));
                },
              ),
              trailing: const Handle(
                child: Icon(Icons.list),
              ),
              title: TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Todo',
                  border: InputBorder.none,
                  counterText: '',
                ),
                maxLength: TodoName.maxLength,
                onChanged: (value) {
                  context.formTodos = context.formTodos.map((listTodo) =>
                      listTodo == todo ? todo.copyWith(name: value) : listTodo);
                  context.read<NoteFormBloc>().add(
                        NoteFormEvent.todosChanged(context.formTodos),
                      );
                },
                validator: (_) {
                  return context
                      .read<NoteFormBloc>()
                      .state
                      .note
                      .todos
                      .value
                      .fold(
                        // failure : 리스트 아이템이 3개 초과 한다는 의미 => 발생할 일이 없기도 하고 개개 아이템에서 처리할 것이 없기 대문에 null 처리
                        (failure) => null,

                        (todoList) => todoList[index].name.value.fold(
                              (failure) => failure.maybeMap(
                                empty: (_) => 'Cannot be empty',
                                exceedingLength: (_) => 'Too long',
                                multiLine: (_) => 'Has to be in a Single line',
                                orElse: () => null,
                              ),
                              (r) => null,
                            ),
                      );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
