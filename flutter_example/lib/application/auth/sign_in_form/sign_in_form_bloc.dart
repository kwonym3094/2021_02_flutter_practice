import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_example/domain/auth/auth_failures.dart';
import 'package:flutter_example/domain/auth/i_auth_facade.dart';
import 'package:flutter_example/domain/auth/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  // BLoC이 해야 할 일: 발생하는 event를 state로 바꿔야함
  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccessOption:
              none(), // Option의 왼쪽 값 <-> some(right(unit)) 은 오른쪽 값, 즉 값을 제대로 받았을 때
          // none 값으로 처리하는 이유? => 에러로 값이 들어올 수도 있으니 매번 업데이트 해주는 개념
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccessOption: none(),
        );
      },
      registerWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
            _authFacade.registerWithEmailAndPassword);
      },
      signInWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
            _authFacade.signInWithEmailAndPassword);
      },
      signInWithGooglePressed: (e) async* {
        // google signin은 이 코드 내부에서 validation을 처리하지 않게 됨
        // flag 값만 바꿔주면 된다
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        );
        final failureOrSuccess = await _authFacade.signInWithGoogle();
        yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess),
        );
      },
    );
  }

  // SignIn과 register 부분이 함수 하나만 다르고 로직이 같기 때문에 refactoring 해줌
  //  - 해당 함수를 Higher Order Function(함수를 인자로 받거나 함수를 결과로 내보내는 함수) or HOF 라고 함
  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function(
            {required EmailAddress emailAddress, required Password password})
        forwardCall,
  ) async* {
    Either<AuthFailure, Unit>?
        failureOrSucess; // 실패, 성공 결과를 동시에 받기 위해서 -> 코드 수가 줄어듬
    // if (state.emailAddress.value.isRight()) {}
    // 위의 방법을 사용해도 되지만 domain/core/value_objects.dart 에서 정의한 super class의 이점을 사용하자
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      // validation 통과시
      //  - state flag 바꿔주기
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSucess = await forwardCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }

    // validation 통과 못했을 경우 + 통과 했을 경우 동시에 포함
    yield state.copyWith(
      isSubmitting: false,
      showErrorMessage: true,
      authFailureOrSuccessOption: optionOf(failureOrSucess),
    );
  }
}
