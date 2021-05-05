// import 'package:dartz/dartz.dart';
// import 'package:flutter_example/domain/core/failures.dart';
// import 'package:flutter_example/domain/core/value_objects.dart';

// class EmailAddress extends ValueObject<String> {
//   // final String value;
//   // => 변환
//   // validation 한 후 추가됨
//   //  - 만약 EmailAddress class 가 정확한 값만 가진다면 Exception이 생길 때 대응하기 어려워짐
//   //  - 밑에서 freezed로 만든 케이스를 넣어 줘야함
//   //  - Either: dartz package 에서 가져옴
//   //    - Either<Left, Right> : 유효하지 않을때는 왼쪽, 유효할 때는 오른쪽
//   @override
//   final Either<ValueFailure<String>, String> value;

//   const EmailAddress._({required this.value});

//   // validated object 만들기가 필요함 => 의미? 적절한 validation check이 맞을 때 값을 할당하는 로직을 갖는 object
//   //  - 필요한 순간(ex. submit)이 아니라 해당 객체가 살아있는 동안 valid 한 값을 갖고 있는 객체로 만들자
//   //     => making illegal states unrepresentable
//   //  - instantiation 할 때 유효하게 하는 가장 직접적 방법 => factory costructor

//   factory EmailAddress(String input) {
//     return EmailAddress._(value: validateEmailAddress(input));
//   }

//   // factory 패턴으로 바꾸면서 원래 constructor 는 ._()의 패턴으로
// }

// // validation : class 와는 따로 분리
// Either<ValueFailure<String>, String> validateEmailAddress(String input) {
//   const emailRegex =
//       r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
//   if (RegExp(emailRegex).hasMatch(input)) {
//     return right(input);
//   } else {
//     // null 을 return 할 수 있지만, 전문가가 (그리고 경험상) null 을 넘기는 것은 좋지 않음 => 대신 Exception을 만들어 사용하는 것으로 함
//     return left(ValueFailure.invalueEmail(failedValue: input));
//     // 잘못된 값이 들어올 때는 EmailAddress가 instantiation 되지 않을 것 임
//   }
// }

// // 모든 값을 일일이 체크 할 수는 있지만, 인계 혹은 시간이 지난 후에 돌아보면 다 기억할 수가 없다
// //  => 그래서 값이 맞지 않을 때 compile time에 체크할 수 있게 하면 좋겠다 => freezed package
// // @freezed
// // abstract class ValueFailure<T> with _$ValueFailure<T> {
// //   const factory ValueFailure.invalueEmail({required String failedValue}) =
// //       InvalidEmail<T>;
// //   const factory ValueFailure.shortPassword({required String failedValue}) =
// //       ShortPassword<T>;
// // }

// // 여태까지 만든 EmailAddress 사용하는 방법, UI 혹은 로직에서 사용하면 됨
// void showEmailAddressOrFailure() {
//   final emailAddress = EmailAddress('fasdafa');

//   // left 인지 right 인지 확인하는 방법 : 긴방법
//   String emailText = emailAddress.value.fold(
//       (left) => 'Failure happened, more precisely: $left', (right) => right);

//   // left 인지 right 인지 확인하는 방법 : 짧은 방법
//   String emailText2 = emailAddress.value
//       .getOrElse(() => 'Some failure happened'); // 정확한 실패에 대해서는 알 수 없음
// }
