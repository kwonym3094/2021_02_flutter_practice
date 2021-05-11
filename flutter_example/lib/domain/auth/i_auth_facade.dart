// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:flutter_example/domain/auth/auth_failures.dart';
import 'package:flutter_example/domain/auth/user.dart';
import 'package:flutter_example/domain/auth/value_objects.dart';

// interface 이기 때문에 바로 DI 처리할 수 없음 => interface와 실제 상속 받아 쓰고 있는 FirebaseAuthFacade를 연결해줘야함
abstract class IAuthFacade {
  // sign-in 된 유저 저장
  Future<Option<User>> getSignedInUser();

  // sign-out 처리
  Future<void> signOut();

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
