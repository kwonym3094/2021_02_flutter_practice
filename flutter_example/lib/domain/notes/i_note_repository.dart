// note value object와 repository를 연결하는 interface
import 'package:dartz/dartz.dart';
import 'package:flutter_example/domain/notes/note.dart';
import 'package:flutter_example/domain/notes/note_failure.dart';
import 'package:kt_dart/kt.dart';

abstract class INoteRepository {
  // 만들어야할 interface
  // - watch notes (firestore 에서만 가능할 듯)
  // - watch uncompleted notes
  // - CUD (R 부분은 위의 두 개)

  // R
  // watch note : 계속 지켜보고 있어야되기때문에 Future이 아니라 Stream
  Stream<Either<NoteFailure, KtList<Note>>> watchAll();
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted();

  // CUD
  // create는 return 타입이 없으니 Unit으로
  Future<Either<NoteFailure, Unit>> create(Note note);
  Future<Either<NoteFailure, Unit>> update(Note note);
  Future<Either<NoteFailure, Unit>> delete(Note note);
}
