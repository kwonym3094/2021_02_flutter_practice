import 'dart:math';

class Bicycle {
  int cadence;
  int _speed = 0;
  int get speed => _speed;
  int gear;

  Bicycle(this.cadence, this.gear);

  void applyBrake(int decrement) {
    _speed -= decrement;
  }

  void speedUp(int increment) {
    _speed += increment;
  }

  @override
  String toString() => 'Bicycle: $_speed mph';
}

// 선택적 오버로딩
class Rectangle {
  int width;
  int height;
  Point origin;

  Rectangle({this.origin = const Point(0, 0), this.width = 0, this.height = 0});

  @override
  String toString() =>
      'Origin: (${origin.x}, ${origin.y}), width: $width, height: $height';
}

// 팩토리 패턴
// 1번 방법 : 전통적 방법
Shape shapeFactory(String type, int num) {
  if (type == 'circle') return Circle(num);
  if (type == 'square') return Square(num);
  throw 'Can\'t create $type';
}

// 2번 방법 : Dart 지원 방법
abstract class Shape{
  factory Shape(String type, int num){
    if (type == 'circle') return Circle(num);
    if (type == 'square') return Square(num);
    throw 'Can\'t create $type';
  }

  num get area;
}

class Circle implements Shape {
  final num radius;
  Circle(this.radius);
  num get area => pi * pow(radius, 2);
}

class Square implements Shape {
  final num side;
  Square(this.side);
  @override
  num get area => pow(side,2);
}

// 인터페이스 : 키워드 없음
class CircleMock implements Circle {
  num area;
  num radius;
}

main() {
//   final circle = Circle(2);
//   final square = Square(2);
//   print(circle.area);
//   print(square.area);

  final circle2 = shapeFactory('circle',2);
  print(circle2.area);

  final circle3 = Shape('circle',2);
  print(circle3.area);

  final circleMock = CircleMock();
  circleMock.area = 2;
  circleMock.radius = 2;
  print(circleMock.area);

}