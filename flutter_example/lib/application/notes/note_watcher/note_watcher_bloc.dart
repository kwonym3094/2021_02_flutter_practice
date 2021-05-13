import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';

import 'package:flutter_example/domain/notes/i_note_repository.dart';
import 'package:flutter_example/domain/notes/note.dart';
import 'package:flutter_example/domain/notes/note_failure.dart';

part 'note_watcher_bloc.freezed.dart';
part 'note_watcher_event.dart';
part 'note_watcher_state.dart';

// injectable : get_it을 통해 다른 곳에 이 bloc instance를 얻을 수 있게 해줌
//              또한 다른 instance를 이 bloc에 넣을 수 있게 해줌

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository _noteRepository;

  NoteWatcherBloc(
    this._noteRepository,
  ) : super(const _Initial());

  // mutable
  StreamSubscription<Either<NoteFailure, KtList<Note>>>?
      _noteStreamSubscription;

  @override
  Stream<NoteWatcherState> mapEventToState(
    NoteWatcherEvent event,
  ) async* {
    yield* event.map(
      watchAllStarted: (e) async* {
        yield const NoteWatcherState.loadInProgress();
        // incorrect way

        // yield* _noteRepository.watchAll(); // 멈추지 않을 것임
        // yield* _noteRepository.watchAll()
        // .map(
        //       (failureOrNotes) => failureOrNotes.fold(
        //           (failure) => NoteWatcherState.loadFailure(failure),
        //           (success) => NoteWatcherState.loadSuccess(success)),
        //     );

        // 위의 방법으로는 watchAllStarted Event에서 다른 이벤트로 바꾸는 것이 일반적인 방법으로는 불가능할 것임.
        //  - 이유 : 위의 yield* 구문이 state를 내놓는 것을 절대 멈추지 않을 것임. 화면이 켜져 있기 때문에 event 전환이 안됨.

        // 다음으로 변환 : listen
        // listen 은 다음 방법으로 취소가 가능하여 다른 event에 대응할 수 있게 됨
        //  - StreamSubscription 이 필요함(위에서 정의) => _noteStreamSubscription => listening 을 취소할 수 있게 해줌
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository.watchAll().listen(
            (failreOrNotes) =>
                add(NoteWatcherEvent.notesReceived(failreOrNotes)));
      },
      watchUnCompletedStarted: (e) async* {
        yield const NoteWatcherState.loadInProgress();
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository.watchUncompleted().listen(
            (failreOrNotes) =>
                add(NoteWatcherEvent.notesReceived(failreOrNotes)));
      },
      notesReceived: (e) async* {
        yield e.failureOrNotes.fold(
            (failure) => NoteWatcherState.loadFailure(failure),
            (success) => NoteWatcherState.loadSuccess(success));
      },
    );
  }

  // 만약의 memory leak 을 막기 위한 처리
  @override
  Future<void> close() async {
    await _noteStreamSubscription?.cancel();
    return super.close();
  }
}
