import 'package:flutter_example/src/model/a.dart';
import 'package:flutter_example/src/model/b.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /*
   * error_rules
   - avoid_relative_lib_imports : 상대경로 import 자제
   - avoid_types_as_parameter_names : 파라미터 이름 정할 때 타입 이름으로 할당 자제
   - no_duplicate_case_values : case 문에 중복 할당하지 말기
   - unrelated_type_equality_checks : 타입이 다른데 비교문 안에 넣지 말기
   - unsafe_html x
   - valid_regexps
  */
  test('avoid_relative_lib_imports', () {
    var aClass = A();
    var bClass = B();
  });

  test('avoid_types_as_parameter_names', () {
    void someFunction(int) {}
    var value = 1;
    someFunction(value);
  });

  test('no_duplicate_case_values', () {
    var a = 2;
    switch (a) {
      case 1:
        print('1!!');
        break;
      case 2:
        print('2!!');
        break;
      case 3:
        print('3!!');
        break;
      case 2:
        print('2222!!');
        break;
    }
    var country = CounTryCodeEnumSample.AD;
    switch (country) {
      case CounTryCodeEnumSample.AD:
      case CounTryCodeEnumSample.AE:
      case CounTryCodeEnumSample.AF:
      case CounTryCodeEnumSample.AG:
      case CounTryCodeEnumSample.AI:
      case CounTryCodeEnumSample.AL:
      case CounTryCodeEnumSample.AM:
      case CounTryCodeEnumSample.AN:
      case CounTryCodeEnumSample.AO:
      case CounTryCodeEnumSample.AQ:
        break;
    }
  });

  test('unrelated_type_equality_checks', () {
    void someFunction() {
      var x = '1';
      if (x == 1) print('someFunction'); // LINT
    }

    void someFunction11(DerivedClass1 instance) {
      var other = DerivedClass2();
      // 서로 다른 클래스에서 생성한 인스턴스를 비교하지 말자
      if (other == instance) print('someFunction11'); // OK
      if (other != instance) print('!someFunction11'); // OK
    }

    // 해결방법 1 : Mixin 클래스 사용
    void someFunction12(Mixin instance) {
      var other = DerivedClass2();
      // 서로 다른 클래스에서 생성한 인스턴스를 비교하지 말자
      if (other == instance) print('someFunction11'); // OK
      if (other != instance) print('!someFunction11'); // OK
    }

    // 해결방법 2 : 부모 상속 사용
    void someFunction13(ClassBase instance) {
      var other = DerivedClass2();
      // 서로 다른 클래스에서 생성한 인스턴스를 비교하지 말자
      if (other == instance) print('someFunction11'); // OK
      if (other != instance) print('!someFunction11'); // OK
    }

    someFunction();
    someFunction11(DerivedClass1());
    someFunction12(DerivedClass2());
    someFunction13(DerivedClass2());
  });

  test('valid_regexps', () {
    // 정규표현식 역슬래시(\)는 확장 문자
    //역슬래시 다음에 일반 문자가 오면 특수문자로 취급하고
    //역슬래시 다음에 특수문자가 오면 그 문자 자체를 의미
    //
    // () 소괄호 안의 문자를 하나의 문자로 인식
    print(RegExp(r'(').hasMatch('foo()'));
    print(RegExp(r'\(').hasMatch('foo()'));
  });
}

class ClassBase {}

abstract class Mixin {}

class DerivedClass3 extends ClassBase {}

class DerivedClass2 extends ClassBase with Mixin {}

class DerivedClass1 {}

enum CounTryCodeEnumSample { AD, AE, AF, AG, AI, AL, AM, AN, AO, AQ }
