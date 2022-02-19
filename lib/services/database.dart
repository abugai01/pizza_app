import 'package:pizza_test/models/profile.dart';
import 'package:pizza_test/models/address.dart';
import 'package:pizza_test/models/item.dart';
import 'package:pizza_test/models/order.dart';
import 'package:pizza_test/services/api_path.dart';
import 'package:pizza_test/services/firestore_service.dart';

abstract class Database {
  Database(this.uid);

  final String? uid;

  Future<Order> getOrder({required String id});
  Future<List<Order>> getOrdersUser({required String uid});
  Future<void> setOrder(Order order);
  Future<void> deleteOrder({required String id});

  Future<List<Item>> getItems();
  Future<Item> getItem({required String id});

  Future<Address> getAddress({required String uid, required String id});
  Future<List<Address>> getAddressesUser({required String uid});
  Future<void> setAddress({required String uid, required Address address});
  Future<void> deleteAddress({required String uid, required String id});
}

class FirestoreDatabase implements Database {
  FirestoreDatabase();

  late String uid;

  final _service = FirestoreService.instance;

  @override
  Future<Order> getOrder({required String id}) => _service.getDocument(
        path: APIPath.order(id),
        builder: (data, documentId) => Order.fromMap(data, documentId),
      );

  @override
  Future<List<Order>> getOrdersUser({required String uid}) =>
      _service.getCollection(
        path: APIPath.orders(),
        builder: (data, documentId) => Order.fromMap(data, documentId),
        queryBuilder: (query) {
          query = query.where('userId', isEqualTo: uid);
          return query;
        },
      );

  @override
  Future<void> setOrder(Order order) => _service.setData(
        path: APIPath.order(order.id),
        data: order.toMap(),
      );

  @override
  Future<void> deleteOrder({required String id}) async {
    await _service.deleteData(path: APIPath.order(id));
  }

  @override
  Future<List<Item>> getItems() => _service.getCollection(
        path: APIPath.items(),
        builder: (data, documentId) => Item.fromMap(data, documentId),
        queryBuilder: (query) {
          query = query.where(Item.IS_AVAILABLE,
              isEqualTo: true); //todo: maybe show in menu but unavailable?
          return query;
        },
      );

  @override
  Future<Item> getItem({required String id}) => _service.getDocument(
        path: APIPath.item(id),
        builder: (data, documentId) => Item.fromMap(data, documentId),
      );

  @override
  Future<Address> getAddress({required String uid, required String id}) =>
      _service.getDocument(
        path: APIPath.address(uid, id),
        builder: (data, documentId) => Address.fromMap(data, documentId),
      );

  @override
  Future<List<Address>> getAddressesUser({required String uid}) =>
      _service.getCollection(
        path: APIPath.addresses(uid),
        builder: (data, documentId) => Address.fromMap(data, documentId),
        queryBuilder: (query) {
          query = query.where('userId', isEqualTo: uid);
          return query;
        },
      );

  //TODO: maybe no need for uid here
  @override
  Future<void> setAddress({required String uid, required Address address}) =>
      _service.setData(
        path: APIPath.address(uid, address.id),
        data: address.toMap(),
      );

  @override
  Future<void> deleteAddress({required String uid, required String id}) async {
    await _service.deleteData(path: APIPath.address(uid, id));
  }
}
