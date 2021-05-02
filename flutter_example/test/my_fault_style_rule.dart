import 'package:flutter_example/src/unnecessary_this_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
/*
  * my fault
  - omit_local_variable_types : 타입이 명확한 경우에는 var 로 써줘라. js 와 다르게 형변환이 되지 않기 때문에 시간 낭비하지말고 var 쓰라고 함.
  - unnecessary_this : jave 습관처럼 클래스 내에서 사용하는 변수, 필드에 대해서 this 쓸 필요 없음 (변수명 같은 것이 있지 않는 이상 쓰지 말자)
  - unnecessary_new : 옛날 소스에서는 많이 사용했었음. 쓸필요 없음.
  - curly_braces_in_flow_control_structures : if, for 문에서 중괄호 사용하라
  - prefer_single_quotes
*/

  test('omit_local_variable_types', () {
    Map<int, List<Person>> groupByZip(Iterable<Person> people) {
      Map<int, List<Person>> peopleByZip = <int, List<Person>>{};
      for (Person person in people) {
        peopleByZip.putIfAbsent(person.zip!, () => <Person>[]);
        peopleByZip[person.zip]!.add(person);
      }
      return peopleByZip;
    }
  });

  testWidgets('unnecessary_this', (WidgetTester tester) async {
    await tester.pumpWidget(UnnecessaryThisWidget());
  });

  test('unnecessary_new', () {
    var person = Person();
    var person1 = new Person();
  });

  test('curly_braces_in_flow_control_structures', () {
    var a = 'C';
    if (a == 'A')
      print('A입니다.');
    else if (a == 'B')
      print('B입니다.');
    else if (a == 'C') print('B입니다.');
  });

  test('prefer_single_quotes', () {
    print("쌍따옴표를 사용하는 것에 대한 style 검증 error ");
    print("쌍따옴표를 사용하는 것에 대한 'style' 검증 Okey ");
  });
}

class Person {
  int? zip;
}
