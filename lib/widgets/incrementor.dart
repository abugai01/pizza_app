import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pizza_test/cubits/menu_cubit.dart';
import 'package:pizza_test/config/style.dart';
import 'package:pizza_test/helpers/screen_navigation.dart';
import 'package:pizza_test/models/order.dart';
import 'package:provider/provider.dart';
import 'package:pizza_test/models/item.dart';
import 'package:pizza_test/helpers/functions.dart';

class Incrementor extends StatelessWidget {
  final int quantity;
  final Function onAdd;
  final Function onSubtract;
  final double buttonSize;
  final double widthBetweenButtons;

  Incrementor({
    required this.quantity,
    required this.onAdd,
    required this.onSubtract,
    this.buttonSize = 32.0,
    this.widthBetweenButtons = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: FloatingActionButton(
            heroTag: null,
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.remove, color: Colors.white),
            onPressed: () {
              onSubtract();
              HapticFeedback.vibrate();
            }),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Align(
              alignment: Alignment.center, child: Text(quantity.toString())),
          width: widthBetweenButtons,
        ),
      ),
      SizedBox(
        height: buttonSize,
        width: buttonSize,
        child: FloatingActionButton(
          heroTag: null,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            onAdd();
            HapticFeedback.vibrate();
          },
        ),
      ),
    ]);
  }
}
