import 'package:flutter_example/model/freezed/freezed_class.dart';

void main() {
  final user = User('Matt', 20);

  print(user);

  final user3 = User('Matt', 20);

  print(user == user3);

  final serialzed = user.toJson();
  final deserialzed = User.fromJson(serialzed);

  print(serialzed);
  print(deserialzed);

  // Union Type
  OperationNested.add(1);

  // Union type case
  final result = performOperation(2, OperationNested.add(2));
  print(result);
}

// check sealed class and when case of kotlin
// 1. when
int performOperation(int operand, OperationNested operation) {
  return operation.when(
    add: (value) => operand + value,
    subtract: (value) => operand - value,
  );
}

// 2. maybeWhen
//  - to safely ignore a certain case of the Union. But orElse must be provided !!!
int performOperationWithMaybe(int operand, OperationNested operation) {
  return operation.maybeWhen(
    add: (value) => operand + value,
    orElse: () => -1,
  );
}

// 3. map
//  - to safely ignore a certain case of the Union. But orElse must be provided !!!
int performOperationWithMap(int operand, Operation operation) {
  return operation.map(
    add: (caseClass) =>
        operand +
        caseClass
            .value, // map does not destructures the contents while destructures the contentes of the case classes (integer)
    subtract: (cassClass) => operand - cassClass.value,
  );
}

// map case is recommended if a programmer uses bloc libraries
