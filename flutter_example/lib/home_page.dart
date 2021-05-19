import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/entity.dart';
import 'package:flutter_example/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'order_data_table.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final faker = Faker();

  // 데이터 접근하기 위해 initialization
  late Store _store;
  bool hasBeenInitialized = false;

  late Customer _customer;

  // database를 watch 하기 위해 Stream 사용
  late Stream<List<ShopOrder>> _stream;

  @override
  void initState() {
    super.initState();
    setNewCustomer();
    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
        getObjectBoxModel(),
        directory: join(dir.path, 'objectbox'),
      ); // getObjectBoxModel >> definition 정보(generated file 안에 있음)
      setState(() {
        // stream 지정
        // query 작성하는 것 잘보기
        _stream = _store
            .box<ShopOrder>()
            .query()
            .watch(triggerImmediately: true)
            .map((query) => query.find());
        // watch : Stream 생성하는 메소드, triggerImmediately => 데이터 가져왔을 때 바로 가져오기
        hasBeenInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    _store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt),
            onPressed: setNewCustomer,
          ),
          IconButton(
            icon: const Icon(Icons.attach_money),
            onPressed: addFakeOrderForCurrentCustomer,
          ),
        ],
      ),
      body: !hasBeenInitialized
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<List<ShopOrder>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return OrderDataTable(
                  orders: snapshot.data!,
                  store: _store,
                  onSort: (columnIndex, ascending) {
                    final newQueryBuilder = _store.box<ShopOrder>().query();
                    final sortField =
                        columnIndex == 0 ? ShopOrder_.id : ShopOrder_.price;
                    // order : 무엇에 따라 정렬할것인지

                    newQueryBuilder.order(
                      sortField,
                      flags: ascending
                          ? 0
                          : Order.descending | Order.caseSensitive,
                    );
                    // order 옵션은 많으니 확인해보기
                    setState(() {
                      _stream = newQueryBuilder
                          .watch(triggerImmediately: true)
                          .map((query) => query.find());
                    });
                  },
                );
              }),
    );
  }

  void setNewCustomer() {
    _customer = Customer(name: faker.person.name());
    // id 는 정의 안하는걸 잘 보기
    // object box가 정의할 것임
  }

  void addFakeOrderForCurrentCustomer() {
    final order = ShopOrder(price: faker.randomGenerator.integer(500, min: 10));
    // customer와 relation 이 있다고 정의하였는데 그 처리는 어떻게 해주는가?
    order.customer.target = _customer;
    // 저장하는 방법
    _store.box<ShopOrder>().put(order);
    // customer이 같은 상태로 계속 저장할 때는 customer 는 저장되지 않고 order 만 계속 저장된다
  }
}
