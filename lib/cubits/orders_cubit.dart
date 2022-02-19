import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_test/models/order.dart';
import 'package:pizza_test/models/item.dart';
import 'package:pizza_test/services/database.dart';

abstract class OrdersState {}

class OrdersInitState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersLoadedState extends OrdersState {
  final List<Order> orders;

  OrdersLoadedState({required this.orders});
}

class OrdersErrorState extends OrdersState {}

class OrdersCubit extends Cubit<OrdersState> {
  final Database database;
  final String uid;

  List<Order> orders = [];

  OrdersCubit(this.database, {required this.uid}) : super(OrdersInitState()) {
    getData();
  }

  void getData() async {
    try {
      emit(OrdersLoadingState());
      orders = await database.getOrdersUser(uid: uid);
      emit(OrdersLoadedState(orders: orders));
    } catch (e) {
      print(e.toString());
      emit(OrdersErrorState());
    }
  }
}
