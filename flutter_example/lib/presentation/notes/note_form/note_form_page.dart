import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_example/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_example/domain/notes/note.dart';
import 'package:flutter_example/presentation/injection.dart';
import 'package:flutter_example/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:flutter_example/presentation/notes/note_form/widgets/add_todo_tile_widget.dart';
import 'package:flutter_example/presentation/notes/note_form/widgets/body_field_widget.dart';
import 'package:flutter_example/presentation/notes/note_form/widgets/color_field_widget.dart';
import 'package:flutter_example/presentation/notes/note_form/widgets/todo_list_widget.dart';
import 'package:flutter_example/presentation/routes/router.gr.dart';
import 'package:provider/provider.dart';

class NoteFormPage extends StatelessWidget {
  final Note? editedNote;

  const NoteFormPage({Key? key, this.editedNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NoteFormBloc>()
        ..add(NoteFormEvent.initialized(optionOf(editedNote))),
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listenWhen: (previous, current) =>
            previous.saveFailureOrSuccessOption !=
            current.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
              () {},
              (either) => either.fold(
                    (failure) async {
                      await showFlash(
                        context: context,
                        duration: const Duration(seconds: 4),
                        builder: (context, controller) => Flash.bar(
                            controller: controller,
                            backgroundColor: Colors.grey.withOpacity(0.8),
                            position: FlashPosition.bottom,
                            enableVerticalDrag: true,
                            horizontalDismissDirection:
                                HorizontalDismissDirection.horizontal,
                            margin: const EdgeInsets.all(8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            forwardAnimationCurve: Curves.easeOutBack,
                            reverseAnimationCurve: Curves.easeOutBack,
                            child: FlashBar(
                              content: Text(failure.map(
                                unexpected: (_) =>
                                    'Unexpected error occured, please contact support.',
                                insufficientPermission: (_) =>
                                    'Insufficient permissions ❌',
                                unableToUpdate: (_) =>
                                    "Coudln't update the note. Was it deleted from another account?",
                              )),
                            )),
                      );
                    },
                    (_) {
                      AutoRouter.of(context).popUntil(
                        (route) =>
                            route.settings.name == NotesOverviewRoute.name,
                      );
                    },
                  ));
        },
        buildWhen: (previous, current) => previous.isSaving != current.isSaving,
        builder: (context, state) => Stack(
          children: [
            const NoteFormPageScaffold(),
            SavingInProgressOverlay(
              isSaving: state.isSaving,
            ),
          ],
        ),
      ),
    );
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({
    Key? key,
    required this.isSaving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 8,
              ),
              Text('Saving...',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white, fontSize: 16))
            ],
          ),
        ),
      ),
    );
  }
}

class NoteFormPageScaffold extends StatelessWidget {
  const NoteFormPageScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NoteFormBloc, NoteFormState>(
          buildWhen: (previous, current) =>
              previous.isEditing != current.isEditing,
          builder: (context, state) {
            return Text(state.isEditing ? 'Edit a note' : 'Create a note');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              context.read<NoteFormBloc>().add(const NoteFormEvent.saved());
            },
          )
        ],
      ),
      body: BlocBuilder<NoteFormBloc, NoteFormState>(
        buildWhen: (previous, current) =>
            previous.showErrorMessage != current.showErrorMessage,
        builder: (context, state) {
          return ChangeNotifierProvider(
            // 빈 primitive 먼저 정의
            create: (_) => FormTodos(),
            child: Form(
              autovalidateMode: state.showErrorMessage,
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    BodyField(),
                    ColorField(),
                    TodoList(),
                    AddTodoTile(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
