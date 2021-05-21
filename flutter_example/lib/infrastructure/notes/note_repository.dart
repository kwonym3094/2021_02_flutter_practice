import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/infrastructure/notes/note_dtos.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

import 'package:flutter_example/domain/notes/i_note_repository.dart';
import 'package:flutter_example/domain/notes/note.dart';
import 'package:flutter_example/domain/notes/note_failure.dart';
import 'package:flutter_example/infrastructure/core/firestore_helpers.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: INoteRepository)
class NoteRepository implements INoteRepository {
  final FirebaseFirestore _firestore;

  // 이런식으로 추상화해서 사용하는게 기본적
  // - 의존적이지 않도록
  // - 일반적인 REST API 사용할 때 추천
  // - 여기서는 다 처리해주는 Firestore을 사용하기 때문에 추상화 안함
  // final NoteRemoteService _noteFirestoreService;
  // final NoteLocalService _noteLocalService;

  NoteRepository(this._firestore);

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchAll() async* {
    // users/{userID}/notes/{noteID}
    // users documents를 얻기 위해 과정이 길기 때문에 extension으로 만듬 => infrastructure/core/firestore_helpers.dart
    final userDoc = await _firestore.userDocument();
    // userDoc.noteCollection.get(); // 이것은 모두 가져옴
    yield* userDoc.noteCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        // 에러 처리 : stream은 여태까지 했던 Either 방식이 아니라 exception으로 처리해야함
        .map((snapshot) => right<NoteFailure, KtList<Note>>(
              snapshot.docs
                  .map((doc) => NoteDto.fromFirestore(doc).toDomain())
                  .toImmutableList(),
            ))
        // rxdart의 다음 extension을 사용하면 left처리도 가능하게 됨
        .onErrorReturnWith((error, stackTrace) {
      if (error is PlatformException &&
          error.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        log(error.toString());
        return left(const NoteFailure.unexpected());
      }
    });
    // snapshot을 잘 살펴보면 QuerySnapshot을 받음 => 항상 에러가 없는 경우만 들어가게 되있음
    // .listen((event) {}, onError: (err) {}); // 이것은 바뀐거만 가져옴
    // 가져온 userDoc 데이터가 순서대로 정리되있지 않다 => 미리 DTO 에서 만들어둔 timestamp 이용
  }

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted() async* {
    // watchAll 복사 후 일부(map) 부분만 수정
    final userDoc = await _firestore.userDocument();
    yield* userDoc.noteCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => NoteDto.fromFirestore(doc).toDomain()))
        // 새로 추가됨
        .map((notes) => right<NoteFailure, KtList<Note>>(notes
            .where((note) =>
                note.todos.getOrCrash().any((todoItem) => !todoItem.done))
            .toImmutableList()))
        .onErrorReturnWith((error, stackTrace) {
      if (error is PlatformException &&
          error.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        log(error.toString());
        return left(const NoteFailure.unexpected());
      }
    });
  }

  @override
  Future<Either<NoteFailure, Unit>> create(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteDto = NoteDto.fromDomain(note);

      await userDoc.noteCollection.doc(noteDto.id).set(noteDto.toJson());

      return right(unit);
    } on PlatformException catch (e) {
      if (e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        return left(const NoteFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<NoteFailure, Unit>> update(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteDto = NoteDto.fromDomain(note);

      // 29 : 다음 부분에서 에러가 발생함 => JsonSerializable을 사용할 때면 발생할 수 있는 에러
      await userDoc.noteCollection.doc(noteDto.id).update(noteDto.toJson());

      return right(unit);
    } on PlatformException catch (e) {
      if (e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } // one more exception!
      else if (e.message!.contains('not-found')) {
        return left(const NoteFailure.unableToUpdate());
      } else {
        return left(const NoteFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<NoteFailure, Unit>> delete(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteId = note.id.getOrCrash();

      await userDoc.noteCollection.doc(noteId).delete();

      return right(unit);
    } on PlatformException catch (e) {
      if (e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else if (e.message!.contains('not-found')) {
        return left(const NoteFailure.unableToUpdate());
      } else {
        return left(const NoteFailure.unexpected());
      }
    }
  }
}
