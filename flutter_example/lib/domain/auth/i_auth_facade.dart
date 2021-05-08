import 'package:dartz/dartz.dart';
import 'package:flutter_example/domain/auth/auth_failures.dart';
import 'package:flutter_example/domain/auth/user.dart';
import 'package:flutter_example/domain/auth/value_objects.dart';

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
