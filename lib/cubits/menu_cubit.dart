import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_test/models/order.dart';
import 'package:pizza_test/models/item.dart';
import 'package:pizza_test/services/database.dart';

//todo: add isAvailable
abstract class MenuState {}

class InitMenuState extends MenuState {}

class LoadingMenuState extends MenuState {}

class LoadedMenuState extends MenuState {
  final List<Item> items;

  LoadedMenuState({required this.items});

  //todo: remove hardcode
  List<Item> get pizzas =>
      items.where((item) => (item.category == 'pizza')).toList();
  List<Item> get beverages =>
      items.where((item) => (item.category == 'beverage')).toList();
  List<Item> get other => items
      .where(
          (item) => (item.category != 'pizza' && item.category != 'beverage'))
      .toList();
}

class ErrorMenuState extends MenuState {}

class MenuCubit extends Cubit<MenuState> {
  final Database database;

  MenuCubit(this.database) : super(InitMenuState()) {
    getData();
  }

  // Used for repeating an order. We want to check whether the items from an old order are still in the menu.
  late List<Item> items;

  Future<void> getData({bool emitLoadingState = true}) async {
    try {
      if (emitLoadingState == true) {
        emit(LoadingMenuState());
      }
      items = await database.getItems();
      emit(LoadedMenuState(items: items));
    } catch (e) {
      emit(ErrorMenuState()); //TODO: show error message
      log(e.toString());
    }
  }
}
