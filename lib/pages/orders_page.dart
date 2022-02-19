import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pizza_test/config/style.dart';
import 'package:pizza_test/widgets/bottom_bar.dart';
import 'package:pizza_test/widgets/order_cards.dart';
import 'package:pizza_test/cubits/orders_cubit.dart';
import 'package:pizza_test/services/database.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double appBarHeight = kToolbarHeight;
    double indicatorWeight = 2;
    double tabBarHeight = appBarHeight - indicatorWeight;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //backgroundColor: themeLightGrey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: Theme.of(context).textTheme.subtitle1,
                    indicatorWeight: indicatorWeight,
                    indicatorColor: Theme.of(context).primaryColor,
                    tabs: [
                      Container(
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text('Active')),
                          height: tabBarHeight),
                      Container(
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text('Completed')),
                          height: tabBarHeight),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(2),
        body: BlocProvider<OrdersCubit>(
          create: (context) =>
              //todo: remove uid hardcode
              OrdersCubit(context.read<FirestoreDatabase>(),
                  uid: 'qmjOrRjxxAaPXeqlHbDhN4zb1lz1'),
          child: TabBarView(children: [
            BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
              //print(state);
              if (state is OrdersLoadedState) {
                return OrderCards(orders: state.orders);
              } else if (state is OrdersErrorState) {
                return const Center(child: Text("Something went wrong"));
              } else {
                return const Center(
                  child: SpinKitWave(color: themeLightGrey),
                );
              }
            }),
            OrderCards(orders: []),
          ]),
        ),
      ),
    );
  }
}
