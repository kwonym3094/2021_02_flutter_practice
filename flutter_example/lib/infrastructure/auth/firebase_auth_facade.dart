// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:flutter_example/domain/auth/auth_failures.dart';
import 'package:flutter_example/domain/auth/i_auth_facade.dart';
import 'package:flutter_example/domain/auth/user.dart' as user;
import 'package:flutter_example/domain/auth/value_objects.dart';
import './firebase_user_mapper.dart';

// interface 는 이렇게 사용한다함
// injection.config.dart 확인해보면 문제가 생기는 것: 3rd party library인 FirebaseAuth와 GoogleSignIn 도 의존성 주입해줘야함
//   => injectable을 위해 module을 따로 만들어 3rd party lib에 직접적 권한을 줘야함 (infrastructure/core/firebase_injectable_module.dart 참고)
@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    // final emailAddressStr = emailAddress.value.fold((failure) => throw UnExpectedValueError(failure), (success) => success); // 반복 되는게 싫다 => super class(to ValueObjects)
    final emailAddressStr =
        emailAddress.getOrCrash(); // 반복 되는게 싫다 => super class(to ValueObjects)
    final passwordStr = password.getOrCrash();
    // 만약 잘못된 값이 들어 온다면 여기까지 오기전에 Error를 뱉어낸다
    try {
      // 거의 모든 exception을 처리해줬지만 try catch 해준 이유?
      //   => 아래에서 사용하는 createUserWithEmailAndPassword의 exception을 확인해봤을 때, AlreadyInUse 의 경우는 exception으로 잡을 수 있기 때문
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    // 다음 내용은 HOF 으로 만들 수 없음 => 이유? exception으로 나오는 메세지 들이 다르기 때문
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        // 조건 나누지 않는 이유? => id가 맞다는 것을 타인에게 노출시키지 않기 위해
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      // 따로 저장
      final googleAuthentication = await googleUser.authentication;
      // firebase에 저장하고 싶다
      // firebase는 credential 이라는 것만 이해한다, 모든 signin provider는 credential 을 제공한다
      // TwitterAuthProvider, GithubAuthProvider 확인해보기 => 모두 FirebaseAuth 패키지에서 나옴

      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );
      // OAuthCredential 을 확인해보면 idToken, accessToken 만 보여주는 Map 객체이다

      return _firebaseAuth
          .signInWithCredential(authCredential)
          .then((result) => right(unit));
    } on PlatformException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Option<user.User>> getSignedInUser() async =>
      optionOf(_firebaseAuth.currentUser?.toDomain());

  @override
  Future<void> signOut() {
    return Future.wait([
      _googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
  }
}
