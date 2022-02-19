import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pizza_test/cubits/cart_cubit.dart';
import 'package:pizza_test/cubits/menu_cubit.dart';
import 'package:pizza_test/config/style.dart';
import 'package:pizza_test/helpers/screen_navigation.dart';
import 'package:pizza_test/models/order.dart';
import 'package:provider/provider.dart';
import 'package:pizza_test/models/item.dart';
import 'package:pizza_test/pages/item_page.dart';

class MenuCards extends StatelessWidget {
  final List<Item> items;

  MenuCards({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: items.length,
      physics:
          const NeverScrollableScrollPhysics(), // To disable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (BuildContext context, int index) {
        return MenuCardWrapper(items[index]);
      },
    );
  }
}

class MenuCardWrapper extends StatelessWidget {
  final Item item;

  MenuCardWrapper(this.item);

  @override
  Widget build(BuildContext context) {
    //todo: maybe buttons logic should be here
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      if (state is DefaultCartState) {
        int howManyInCart = 0;
        for (int i = 0; i < state.items.length; i++) {
          if (state.items[i].id == item.id) {
            howManyInCart = state.items[i].quantity;
            break;
          }
        }
        return MenuCard(item, howManyInCart: howManyInCart);
      } else {
        return MenuCard(item);
      }
    });
  }
}

class MenuCard extends StatelessWidget {
  final Item item;
  final int howManyInCart;

  MenuCard(this.item, {this.howManyInCart = 0});

  @override
  Widget build(BuildContext context) {
    final bool isInCart = howManyInCart > 0 ? true : false;

    return GestureDetector(
      onTap: () {
        changeScreen(context, ItemPage(item));
      },
      child: Card(
        color: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: isInCart == true ? 160 : 180,
                    //color: Colors.red,
                    //padding: EdgeInsets.all(5),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: item.image,
                        placeholder: (context, url) =>
                            const SpinKitFadingCircle(color: themeLightGrey),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(item.name)),
                isInCart == true
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(item.priceFormatted,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)))
                    : const SizedBox(),
                isInCart == true
                    ? Container(
                        height: 32,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // 'Subtract' button
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    context.read<CartCubit>().addOrSubtract(
                                        item.id,
                                        increment:
                                            false); //todo: rebuild state!!!
                                    HapticFeedback.vibrate();
                                  },
                                  icon: const Icon(Icons.remove,
                                      color: Colors.white)),
                              Expanded(child: Container()),
                              Text(
                                context
                                    .read<CartCubit>()
                                    .howManyInCart(item.id)
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(child: Container()),
                              // 'Add' button
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    context.read<CartCubit>().addOrSubtract(
                                        item.id,
                                        increment:
                                            true); //todo: rebuild state!!!
                                    HapticFeedback.vibrate();
                                  },
                                  icon: const Icon(Icons.add,
                                      color: Colors.white)),
                            ]),
                      )
                    : Row(children: [
                        Text(
                          item.priceFormatted,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle),
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  context.read<CartCubit>().addItemToCart(item);
                                  HapticFeedback.vibrate();
                                },
                                icon: const Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                  size: 22,
                                ))),
                      ])
              ]),
        ),
      ),
    );
  }
}
