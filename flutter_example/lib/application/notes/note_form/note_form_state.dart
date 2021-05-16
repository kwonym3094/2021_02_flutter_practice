part of 'note_form_bloc.dart';

@freezed
class NoteFormState with _$NoteFormState {
  const factory NoteFormState({
    required Note note,
    required AutovalidateMode showErrorMessage,
    required bool isSaving,
    required bool isEditing,
    required Option<Either<NoteFailure, Unit>> saveFailureOrSuccessOption,
  }) = _NoteFormState;

  factory NoteFormState.initial() => NoteFormState(
        note: Note.empty(),
        showErrorMessage: AutovalidateMode.disabled,
        isSaving: false,
        isEditing: false,
        saveFailureOrSuccessOption: none(),
      );
}
