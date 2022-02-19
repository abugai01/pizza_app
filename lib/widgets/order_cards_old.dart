import 'package:flutter/material.dart';
import 'package:pizza_test/cubits/menu_cubit.dart';
import 'package:pizza_test/config/style.dart';
import 'package:pizza_test/helpers/screen_navigation.dart';
import 'package:pizza_test/models/order.dart';
import 'package:provider/provider.dart';
import 'package:pizza_test/models/item.dart';

class OrderCards extends StatelessWidget {
  final List<Item> items;

  OrderCards({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return itemCardBuilder(items[index], context);
      },
    );
  }

  Widget itemCardBuilder(Item item, BuildContext context) {
    double listTileHeight = 35;
    return GestureDetector(
        onTap: () {
          onCardTapped(context, item);
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            height: 216,
            child: Card(
                color: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //Верхняя строка с названием услуги и статусом
                      Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  item.name ?? '',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      //color: Colors.grey,
                                      fontSize: 18),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                      height: 22,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(item.calories.toString(),
                                            //textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        color: Colors.grey,
                                      )))
                            ],
                          )),
                      //Время оказания услуги
                      SizedBox(
                          height: listTileHeight,
                          child: ListTile(
                            leading: Icon(Icons.event_outlined, size: 24),
                            //dense: true,
                            title: Text(
                                item.description ?? 'fiuck'), //TODO: nul safety
                            enabled: false,
                            minLeadingWidth: 10,
                          )),
                      //TODO: здесь что-то должно быть для других услуг
                      //Продолжительность
                      SizedBox(
                          height: listTileHeight,
                          child: ListTile(
                            leading: Icon(Icons.timer_outlined, size: 24),
                            //dense: true,
                            title: Text(item.calories.toString()),
                            enabled: false,
                            minLeadingWidth: 10,
                          )),
                      //Имя питомца
                      SizedBox(
                          height: listTileHeight,
                          child: ListTile(
                            leading: Icon(Icons.pets_outlined, size: 24),
                            //dense: true,
                            title: Text(item.name ?? 'kok'),
                            enabled: false,
                            minLeadingWidth: 10,
                          )),
                      //Адрес
                      SizedBox(
                          height: listTileHeight,
                          child: ListTile(
                            leading: Icon(Icons.location_on_outlined, size: 24),
                            //dense: true,
                            title: Text(item.category ?? 'piss'),
                            enabled: false,
                            minLeadingWidth: 10,
                          )),
                    ]))));
  }

  onCardTapped(BuildContext _context, Item item,
      {String? currentWalkingOrderId}) {
    // final MenuCubit menuCubit = _context.read<MenuCubit>();
    // menuCubit.item = item;
    // changeScreen(_context, OrderInfoPage());
  }
}
