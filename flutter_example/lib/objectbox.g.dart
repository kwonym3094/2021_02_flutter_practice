// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';

import 'entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3486152596496003408),
      name: 'ShopOrder',
      lastPropertyId: const IdUid(3, 1587349788030249917),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4762780467557126777),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6928795001316086800),
            name: 'price',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1587349788030249917),
            name: 'customerId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 4647713949533758284),
            relationTarget: 'Customer')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 8842578061425241428),
      name: 'Customer',
      lastPropertyId: const IdUid(2, 4406896302793959161),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1723580609165162475),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4406896302793959161),
            name: 'name',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'orders', srcEntity: 'ShopOrder', srcField: '')
      ])
];

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 8842578061425241428),
      lastIndexId: const IdUid(1, 4647713949533758284),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    ShopOrder: EntityDefinition<ShopOrder>(
        model: _entities[0],
        toOneRelations: (ShopOrder object) => [object.customer],
        toManyRelations: (ShopOrder object) => {},
        getId: (ShopOrder object) => object.id,
        setId: (ShopOrder object, int id) {
          object.id = id;
        },
        objectToFB: (ShopOrder object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.price);
          fbb.addInt64(2, object.customer.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ShopOrder(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              price:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0));
          object.customer.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.customer.attach(store);
          return object;
        }),
    Customer: EntityDefinition<Customer>(
        model: _entities[1],
        toOneRelations: (Customer object) => [],
        toManyRelations: (Customer object) => {
              RelInfo<ShopOrder>.toOneBacklink(3, object.id,
                  (ShopOrder srcObject) => srcObject.customer): object.orders
            },
        getId: (Customer object) => object.id,
        setId: (Customer object, int id) {
          object.id = id;
        },
        objectToFB: (Customer object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Customer(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''));
          InternalToManyAccess.setRelInfo(
              object.orders,
              store,
              RelInfo<ShopOrder>.toOneBacklink(
                  3, object.id, (ShopOrder srcObject) => srcObject.customer),
              store.box<Customer>());
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [ShopOrder] entity fields to define ObjectBox queries.
class ShopOrder_ {
  /// see [ShopOrder.id]
  static final id = QueryIntegerProperty<ShopOrder>(_entities[0].properties[0]);

  /// see [ShopOrder.price]
  static final price =
      QueryIntegerProperty<ShopOrder>(_entities[0].properties[1]);

  /// see [ShopOrder.customer]
  static final customer =
      QueryRelationProperty<ShopOrder, Customer>(_entities[0].properties[2]);
}

/// [Customer] entity fields to define ObjectBox queries.
class Customer_ {
  /// see [Customer.id]
  static final id = QueryIntegerProperty<Customer>(_entities[1].properties[0]);

  /// see [Customer.name]
  static final name = QueryStringProperty<Customer>(_entities[1].properties[1]);
}
