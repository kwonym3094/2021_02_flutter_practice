class StringUtil {
  static bool isValidEmail(String str) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(str);
  }
}

// the code above is unnatural => we can change this with "extension" keyword!

// it makes developers extend the class created by others like String, int

extension StringExtensions on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  String concatWithSpace(String other) {
    return '$this $other';
  }

  // how to define custom operator
  String operator &(String other) => '$this $other';
}

// extension IntExtensions on int {
//   int get addTen => this+10;
// }

// extension DoubleExtensions on double{
//   double get addTehn => this+10;
// }
// => just a simple duplication of IntExtensions !

// extension NumExtensions on num{
// //   num get addTen => this+10;
//   // this will occur runtime error!
//   // needs generic type!
//   // =>
// }

extension NumGenericExtensions<T extends num> on T {
  T addTen() => (this + 10) as T;
}

void main() {
  dynamic output = "email@gmail.com".isValidEmail;
  print(output);

  dynamic output2 = 'first'.concatWithSpace("trial");
  print(output2);

  dynamic output3 = 'first' & "trial";
  print(output3);

  int output4 = 1.addTen();
  print(output4);

  double output5 = 1.0.addTen();
  print(output5);
}
