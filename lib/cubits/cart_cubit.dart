import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_test/models/order.dart';
import 'package:pizza_test/models/item.dart';
import 'package:pizza_test/services/database.dart';

abstract class CartState {}

//todo: name it some other way maybe?
class DefaultCartState extends CartState {
  final List<Item> items;
  final num total;

  DefaultCartState({required this.items}) : total = calculateTotal(items);
}

class CartCubit extends Cubit<CartState> {
  final Database database;

  late List<Item> _items;

  CartCubit(this.database) : super(DefaultCartState(items: [])) {
    _items = [];
  }

  void addItemToCart(Item item) {
    //todo : make multiple adding
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == item.id) {
        _items[i].quantity += 1;
        emit(DefaultCartState(items: _items));
        return;
      }
    }

    item.quantity = 1;
    _items.add(item);
    emit(DefaultCartState(items: _items));
  }

  void addOrSubtract(String id, {bool increment = true}) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        if (increment == true) {
          _items[i].quantity += 1;
          emit(DefaultCartState(items: _items));
        } else {
          _items[i].quantity -= 1;

          if (_items[i].quantity <= 0) {
            _items.removeAt(i);
          }
          emit(DefaultCartState(items: _items));
        }
        break;
      }
    }
    emit(DefaultCartState(items: _items));
  }

  int howManyInCart(String id) {
    int res = 0;

    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        res += _items[i].quantity;
      }
    }
    return res;
  }

  void emptyCart() {
    _items = [];
    emit(DefaultCartState(items: _items));
  }

  void removeFromCart(String id) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        _items.removeAt(i);
        emit(DefaultCartState(items: _items));
        break;
      }
    }
    emit(DefaultCartState(items: _items));
  }

  //TODO: show a notification if ok!!!
  Future<void> createOrder() async {
    try {
      print("trying");
      await database.setOrder(Order.create(
          items: _items,
          total: calculateTotal(_items),
          userId: 'qmjOrRjxxAaPXeqlHbDhN4zb1lz1')); //todo: userId pass!
      print("order created");
      emptyCart();
    } catch (e) {
      print(e.toString());
    }
  }

  // It is used for repeating an order
  Future<void> repeatOrder(List<Item> oldItems, List<Item> menuItems) async {
    emptyCart();

    List<Item> newCart = [];

    for (int i = 0; i < oldItems.length; i++) {
      for (int j = 0; j < menuItems.length; j++) {
        if (oldItems[i].id == menuItems[j].id) {
          Item _item = menuItems[j];
          _item.quantity = oldItems[i].quantity;
          newCart.add(_item);
        }
      }
    }

    _items = newCart;
    emit(DefaultCartState(items: _items));
  }
}

calculateTotal(List<Item> items) {
  num res = 0;

  for (int i = 0; i < items.length; i++) {
    res += items[i].subtotal;
  }

  return res;
}
