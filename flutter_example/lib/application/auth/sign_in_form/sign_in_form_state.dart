part of 'sign_in_form_bloc.dart';

@freezed
class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    required EmailAddress emailAddress,
    required Password password,
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>>
        authFailureOrSuccessOption, // user 가 signin button을 누르기 전까지는 값이 없음 => 불완전함 => Option type 추가
    // Option : non-nullable type
    // Unit : nullable type
    //  - 둘 모두 null로 처리할 시 발생하는 오류를 잡기 위해 사용함
    // Option<None,Some> // Either<Left, Right> 와 비슷함
    required bool showErrorMessage, // 아무 버튼이나 한번 누른 후에 발동할 수 있도록 처리하는 로직
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        showErrorMessage: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );
}
