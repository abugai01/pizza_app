import 'package:flutter/material.dart';
import 'package:pizza_test/config/style.dart';
import 'package:pizza_test/helpers/screen_navigation.dart';
import 'package:pizza_test/pages/cart_page.dart';
import 'package:pizza_test/pages/menu_page.dart';
import 'package:pizza_test/pages/profile/profile_page.dart';

import 'package:pizza_test/pages/orders_page.dart';
import 'package:pizza_test/widgets/shopping_cart_icon.dart';

class BottomBar extends StatefulWidget {
  final int selectedIndex;

  BottomBar(this.selectedIndex);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  //final double verticalPadding = 5;

  @override
  Widget build(BuildContext context) {
    const double verticalPadding = 3;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 24,
      backgroundColor: white,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle:
          TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
      unselectedLabelStyle:
          TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                child: Icon(Icons.flash_on_outlined)),
            label: 'Menu'),
        // BottomNavigationBarItem(
        //   icon: Padding(
        //       padding: EdgeInsets.symmetric(vertical: verticalPadding),
        //       child: Icon(Icons.card_membership_outlined)),
        //   label: 'Абонементы',
        // ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            //child: Icon(Icons.shopping_cart),
            child: ShoppingCartIcon(), //TODO: pass number of items here
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              child: Icon(Icons.checklist_rtl)),
          label: 'Orders',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              child: Icon(Icons.person)),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: onItemTapped,
    );
  }

  void onItemTapped(int index) {
    if (index == widget.selectedIndex) return;

    switch (index) {
      case 0:
        changeScreenWithoutAnimation(context, MenuPage());
        break;
      case 1:
        changeScreenWithoutAnimation(context, CartPage());
        break;
      case 2:
        changeScreenWithoutAnimation(context, OrdersPage());
        break;
      case 3:
        changeScreenWithoutAnimation(context, ProfilePage());
        break;
    }
  }
}
