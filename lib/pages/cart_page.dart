import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_test/cubits/cart_cubit.dart';
import 'package:pizza_test/widgets/bottom_bar.dart';
import 'package:pizza_test/widgets/cart_card.dart';
import 'package:pizza_test/config/constants.dart';
import 'package:pizza_test/helpers/functions.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart', style: TextStyle(color: Colors.white)),
        //centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.white,
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  showEmptyCartConfirmWindow(context),
            ),
          )
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        if (state is DefaultCartState) {
          if (state.items.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index < state.items.length) {
                        return CartCard(
                          item: state.items[index],
                          quantity: state.items[index].quantity,
                          onDismissed: () {
                            //Important to pass item name to snackBar before actually removing the item, otherwise RangeError will be thrown due to nue state emission
                            showDeletionSnackBar(context,
                                itemName: state.items[index].name);
                            context
                                .read<CartCubit>()
                                .removeFromCart(state.items[index].id);
                          },
                          onAdd: () {
                            context
                                .read<CartCubit>()
                                .addOrSubtract(state.items[index].id);
                          },
                          onSubtract: () {
                            context.read<CartCubit>().addOrSubtract(
                                state.items[index].id,
                                increment: false);
                          },
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 30),
                                const Text(
                                  "Order summary",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text("Items: " + state.items.length.toString()),
                                const SizedBox(height: 10),
                                const Divider(
                                  height: 10,
                                  thickness: 0.5,
                                  //indent: 5,
                                  //endIndent: 5,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Total: " + formatWithCurrency(state.total),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: MaterialButton(
                    child: Row(children: <Widget>[
                      const SizedBox(width: 75),
                      Expanded(child: Container()),
                      const Text(
                        "CHECKOUT",
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        width: 75,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formatWithCurrency(state.total),
                            style: const TextStyle(
                                fontSize: 12,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ]),
                    color: Theme.of(context).primaryColor,
                    minWidth: double.maxFinite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      //side: BorderSide(color: Colors.red),
                    ),
                    onPressed: () {
                      context.read<CartCubit>().createOrder();
                    },
                  ),
                ),
                const SizedBox(height: 5),
              ],
            );
          } else {
            return const Center(child: Text("Your cart is currently empty"));
          }
        } else {
          return const Center(child: Text("Oops, something went wrong"));
        }
      }),
      bottomNavigationBar: BottomBar(1),
    );
  }

  AlertDialog showEmptyCartConfirmWindow(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete all items?'),
      content:
          const Text('Are you sure you want to delete all items in your cart?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            context.read<CartCubit>().emptyCart();
            Navigator.pop(context);
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  showDeletionSnackBar(BuildContext context, {String? itemName}) {
    String text = itemName == null
        ? 'Item removed from cart'
        : '$itemName removed from cart';

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(milliseconds: 750),
        // action: SnackBarAction(
        //   label: 'Undo',
        //   onPressed: () {},
        // ),
      ),
    );
  }
}
