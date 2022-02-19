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

class CategoryCard extends StatelessWidget {
  final String name;
  //final Image image;
  final Color color;

  CategoryCard(this.name,
      {this.color = themeLightGrey}); //, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //changeScreen(context, ItemPage(item));
        //todo: implement category page
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 6),
                    child: Text(name,
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      //color: Colors.red,
                      //padding: EdgeInsets.all(5),
                      child: Center(
                        child:
                            Image(image: AssetImage('assets/images/pizza.png')),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
