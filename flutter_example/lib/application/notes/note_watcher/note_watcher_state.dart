part of 'note_watcher_bloc.dart';

@freezed
class NoteWatcherState with _$NoteWatcherState {
  const factory NoteWatcherState.initial() = _Initial; // 이벤트 생성 안된 상태
  const factory NoteWatcherState.loadInProgress() = _LoadInProgress; // 로딩 중
  const factory NoteWatcherState.loadSuccess(KtList<Note> notes) = _LoadSuccess;
  const factory NoteWatcherState.loadFailure(NoteFailure noteFailure) =
      _LoadFailure;
}
