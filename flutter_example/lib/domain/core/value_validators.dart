// validation : class 와는 따로 분리

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:flutter_example/domain/core/failures.dart';
import 'package:kt_dart/kt.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    // null 을 return 할 수 있지만, 전문가가 (그리고 경험상) null 을 넘기는 것은 좋지 않음 => 대신 Exception을 만들어 사용하는 것으로 함
    return left(ValueFailure.invalidEmail(failedValue: input));
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

Either<ValueFailure<String>, String> validateMaxStringLength(
    String input, int maxLength) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
        ValueFailure.exceedingLength(failedValue: input, max: maxLength));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (!input.contains('\n')) {
    return right(input);
  } else {
    return left(ValueFailure.multiLine(failedValue: input));
  }
}

// 그냥 List 써도 되지만 List는 immutable이 아님 => copy 만드는 것이 불가능하여 memory 직접 수정해줘야함 => 에러 만들 가능성이 높음
Either<ValueFailure<KtList<T>>, KtList<T>> validateMaxListLength<T>(
    KtList<T> input, int maxLength) {
  if (input.size <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.listTooLong(failedValue: input, max: maxLength));
  }
}
