import 'package:objectbox/objectbox.dart';

// @Entity() 사용하여 object box annotation 함
@Entity()
class ShopOrder {
  // id 는 object box가 지정해줄 것임
  int id;
  int price;
  // relation 정의하는 방법
  // 주문 하나당 id는 하나지만 주문자는 그보다 작을 수 있음
  final customer = ToOne<Customer>();

  ShopOrder({
    this.id = 0,
    required this.price,
  });
}

// ShopOrder Entity와 relation 만들어 사용
@Entity()
class Customer {
  int id;
  String name;

  // 사용자는 여러개의 주문을 할 수 있음
  @Backlink() // Backlink: 여기서 Customer는 ShopOrder과의 관계를 보고(=backlinked) 정의된다는 의미
  final orders = ToMany<ShopOrder>();

  Customer({
    this.id = 0,
    required this.name,
  });
}

// build runner 를 통해 code generation 수행하면 objectbox-model.json, objectbox.g.dart 파일 생성됨. objectbox.g.dart는 git에 올릴 필요 없지만 json 파일은 올려줘야함
