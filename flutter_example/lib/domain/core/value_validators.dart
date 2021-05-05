// validation : class 와는 따로 분리
import 'package:dartz/dartz.dart';
import 'package:flutter_example/domain/core/failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    // null 을 return 할 수 있지만, 전문가가 (그리고 경험상) null 을 넘기는 것은 좋지 않음 => 대신 Exception을 만들어 사용하는 것으로 함
    return left(ValueFailure.invalueEmail(failedValue: input));
    // 잘못된 값이 들어올 때는 EmailAddress가 instantiation 되지 않을 것 임
  }
}

// password 길이 체크
Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}
