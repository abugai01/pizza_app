import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pizza_test/cubits/menu_cubit.dart';
import 'package:pizza_test/config/style.dart';
import 'package:pizza_test/helpers/screen_navigation.dart';
import 'package:pizza_test/models/order.dart';
import 'package:provider/provider.dart';
import 'package:pizza_test/models/item.dart';
import 'package:pizza_test/cubits/cart_cubit.dart';

class ShoppingCartIcon extends StatelessWidget {
  ShoppingCartIcon();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      if (state is DefaultCartState) {
        int quantity = state.items.length;

        return quantity == 0
            ? const Icon(Icons.shopping_cart)
            : Stack(clipBehavior: Clip.none, children: <Widget>[
                const Icon(Icons.shopping_cart),
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    height: 14,
                    width: 14,
                    //margin: EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                      color: themeYellow,
                      shape: BoxShape.circle,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(quantity.toString(),
                          style: const TextStyle(
                              //color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 8)),
                    ),
                  ),
                ),
              ]);
      } else {
        return const Icon(Icons.shopping_cart);
      }
    });
  }
}
