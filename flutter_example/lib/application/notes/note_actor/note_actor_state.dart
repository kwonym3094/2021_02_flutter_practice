part of 'note_actor_bloc.dart';

@freezed
class NoteActorState with _$NoteActorState {
  const factory NoteActorState.initial() = _Initial; // 아무것도 없는 상태
  const factory NoteActorState.actionProgress() = _ActionProgress;
  const factory NoteActorState.deleteFailure(NoteFailure noteFailure) =
      _DeleteFailure;
  const factory NoteActorState.deleteSuccess() = _DeleteSuccess;
}
