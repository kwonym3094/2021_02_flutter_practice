import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_example/domain/core/failures.dart';
import 'package:flutter_example/domain/core/value_objects.dart';
import 'package:flutter_example/domain/core/value_transformer.dart';
import 'package:flutter_example/domain/core/value_validators.dart';
import 'package:kt_dart/collection.dart';

class NoteBody extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const NoteBody._(this.value);

  static const maxLength = 1000;

  factory NoteBody(String input) {
    assert(input != null);

    // 2개를 validating 해야할 때는 어떻게 해야하는지 확인
    return NoteBody._(validateMaxStringLength(input, maxLength).flatMap(
        // (valueFromPreviousF) => validateStringNotEmpty(valueFromPreviousF)));
        validateStringNotEmpty)); // 위를 짧게
    // flatMap : 이전 함수로 부터 value 를 받아서 다음 함수를 실행 = binding
    //  - beatiful property!
    //    * 만약 flatMap 이 전달 되기 전 함수에서 ValueFailure이 발생하면 flatMap 안의 함수는 실행되지 않음
    // -if(false && true)
    // - 위의 코드에서 true는 dead code가 됨 (=볼필요도 없다는 의미)
    // - true는 아예 거치지도 않게 됨 => right-bias 라고 함
  }
}

class TodoName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const TodoName._(this.value);

  static const maxLength = 30;

  factory TodoName(String input) {
    assert(input != null);

    return TodoName._(validateMaxStringLength(input, maxLength)
        .flatMap(validateStringNotEmpty)
        .flatMap(validateSingleLine));
  }
}

class NoteColor extends ValueObject<Color> {
  @override
  final Either<ValueFailure<Color>, Color> value;

  const NoteColor._(this.value);

  static const List<Color> predefinedColors = [
    Color(0xfffafafa),
    Color(0xfffa8072),
    Color(0xfffedc56),
    Color(0xffd0f0c0),
    Color(0xfffca3b7),
    Color(0xff997950),
    Color(0xfffffdd0),
  ];

  factory NoteColor(Color input) {
    assert(input != null);

    return NoteColor._(
      // transparency 없이 안전처리
      right(makeColorOpaque(input)),
    );
  }
}

class List3<T> extends ValueObject<KtList<T>> {
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;

  const List3._(this.value);

  static const maxLength = 3;

  factory List3(KtList<T> input) {
    assert(input != null);

    return List3._(
      validateMaxListLength(input, maxLength),
    );
  }

  // 다음과 같은 getter 만듬
  //  - 이유 : clean 하게 만들기 위해

  // list 이기 때문에 length 확인하는 getter 작성
  int get length {
    return value.getOrElse(() => emptyList()).size;
    // emptyList => KtDart 에서 지원하는 api
  }

  // clean 하게 만들기 위해 isFull getter도 만들어줌
  bool get isFull {
    return length == maxLength;
  }
}
