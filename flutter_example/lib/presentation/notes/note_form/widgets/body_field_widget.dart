import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_example/domain/notes/value_objects.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// State들을 자동으로 처리하게 해주기 위해 HookWidget을 사용하는 것을 잘 확인하자
class BodyField extends HookWidget {
  const BodyField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        textEditingController.text = state.note.body.getOrCrash();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
            // hint
            labelText: 'Note',
            // 몇자 썼는지 보이는 부분
            counterText: '',
          ),
          maxLength: NoteBody.maxLength,
          // 내려쓰기 가능하게 하려면 maxLines: null
          maxLines: null,
          minLines: 5,
          onChanged: (value) => context
              .read<NoteFormBloc>()
              .add(NoteFormEvent.bodyChanged(value)),
          // sign in form 다시 확인하면 무슨 의미인지 알 수 있음
          //  - validate 하는 순간에 커서가 있는 데이터까지 인식하지 않기 때문에 해주는 절차
          validator: (_) =>
              context.read<NoteFormBloc>().state.note.body.value.fold(
                    (failure) => failure.maybeMap(
                      empty: (failure) => 'Cannot be empty',
                      exceedingLength: (failure) =>
                          'Exceeding length, max: ${failure.max}',
                      orElse: () => null,
                    ),
                    (_) => null,
                  ),
        ),
      ),
    );
  }
}
