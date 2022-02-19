import 'package:flutter/material.dart';
import 'package:pizza_test/helpers/screen_navigation.dart';
import 'package:pizza_test/widgets/bottom_bar.dart';
import 'package:pizza_test/pages/orders_page.dart';

class MyAddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My addresses',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 15),
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            const SizedBox(width: 15),
            const CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage('assets/images/pizza.png')),
            const SizedBox(width: 15),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Alexander Bugay", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 5),
                  Text("+79150554477"),
                ]),
          ]),
          Divider(
            height: 24,
            thickness: 0.5,
            indent: 12,
            endIndent: 12,
            color: Colors.grey[350],
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.accessibility_new),
            title: const Text("My info"),
            trailing: null,
            //onTap: () => changeScreen(context, OrdersPage()),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.maps_home_work),
            title: const Text("My address"),
            trailing: null,
            //onTap: () => changeScreen(context, OrdersPage()),
          ),
          const ListTile(
            horizontalTitleGap: 0,
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Sign out"),
            textColor: Colors.red,
            trailing: null,
            //onTap: () => changeScreen(context, OrdersPage()),
          ),
        ],
      ),
    );
  }
}
