import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_example/domain/notes/i_note_repository.dart';
import 'package:flutter_example/domain/notes/note.dart';
import 'package:flutter_example/domain/notes/note_failure.dart';

part 'note_actor_bloc.freezed.dart';
part 'note_actor_event.dart';
part 'note_actor_state.dart';

@injectable
class NoteActorBloc extends Bloc<NoteActorEvent, NoteActorState> {
  final INoteRepository _noteRepository;

  NoteActorBloc(
    this._noteRepository,
  ) : super(const _Initial());

  @override
  Stream<NoteActorState> mapEventToState(
    NoteActorEvent event,
  ) async* {
    // 이벤트가 하나 이기 때문에 NoteActorEvent를 Union이 아니라 DataClass로 만들게 됨
    yield const NoteActorState.actionProgress();
    final possibleFailure = await _noteRepository.delete(event.note);
    yield possibleFailure.fold(
        (failure) => NoteActorState.deleteFailure(failure),
        (_) => const NoteActorState.deleteSuccess());
  }
}
