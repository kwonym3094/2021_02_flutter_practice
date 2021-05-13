part of 'note_watcher_bloc.dart';

@freezed
class NoteWatcherEvent with _$NoteWatcherEvent {
  const factory NoteWatcherEvent.watchAllStarted() = _WatchAllStarted;
  const factory NoteWatcherEvent.watchUnCompletedStarted() =
      _WatchUnCompletedStarted;
  // 오직 전환하기 위해서 사용하는 event (NoteWatcherBloc 참고 : yield* 에서 무한 loop를 돌기 때문)
  const factory NoteWatcherEvent.notesReceived(
      Either<NoteFailure, KtList<Note>> failureOrNotes) = _NotesReceived;
}
