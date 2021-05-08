import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

// 간단한 튜토리얼 이기 때문에 모든 valuefailure을 한곳에 적었다
// 서비스 규모가 커지게 되면 여기 모든 에러를 다 적을 수 없다 => 어떻게 해야하나?
//  - root class를 nesting 하는 방식으로 !
//  - 밑의 주석을 참고하자
@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  // Authentication Error
  const factory ValueFailure.invalueEmail({required T failedValue}) =
      InvalidEmail<T>;
  const factory ValueFailure.shortPassword({required T failedValue}) =
      ShortPassword<T>;

  // Note Creation Error
  const factory ValueFailure.exceedingLength(
      {required T failedValue, required int max}) = ExceedingLength<T>;
  const factory ValueFailure.empty({required T failedValue}) = Empty<T>;
  const factory ValueFailure.multiLine({required T failedValue}) = MultiLine<T>;
  const factory ValueFailure.listTooLong(
      {required T failedValue, required int max}) = ListTooLong<T>;
}

// @freezed
// class ValueFailure<T> with _$ValueFailure<T> {
//   const factory ValueFailure.auth(AuthFailure<T> f) =
//       _Auth<T>;
//   const factory ValueFailure.notes(NotesFailure<T> f) =
//       _Notes<T>;
// }

//  원래는 다음과 같이 상속해서 사용하면 됨
//  - 근데 만약 여러개 feature 가 동시에 failure이 발생하는 경우는 어떻게 되는가?
//  - ex. AuthValueFailure + NotesValueFailure
//  - 이래서 nesting 을 사용해야함

// @freezed
// class AuthValueFailure<T> with _$AuthValueFailure<T> {
//   const factory AuthValueFailure.invalueEmail({required T failedValue}) =
//       InvalidEmail<T>;
//   const factory AuthValueFailure.shortPassword({required T failedValue}) =
//       ShortPassword<T>;
// }

// @freezed
// class NotesValueFailure<T> with _$NotesValueFailure<T> {
//   const factory NotesValueFailure.exceedingLength({required T failedValue}) =
//       ExceedingLength<T>;
// }
