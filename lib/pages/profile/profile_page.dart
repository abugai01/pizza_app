import 'package:flutter/material.dart';
import 'package:pizza_test/helpers/screen_navigation.dart';
import 'package:pizza_test/pages/profile/screens/my_addresses_page.dart';
import 'package:pizza_test/pages/profile/screens/my_info_page.dart';
import 'package:pizza_test/widgets/bottom_bar.dart';
import 'package:pizza_test/pages/orders_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        elevation: 0,
        automaticallyImplyLeading: false,
        //centerTitle: true,
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
            onTap: () => changeScreen(context, MyInfoPage()),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.maps_home_work),
            title: const Text("My addresses"),
            trailing: null,
            onTap: () => changeScreen(context, MyAddressesPage()),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Sign out"),
            textColor: Colors.red,
            trailing: null,
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  showSignOutConfirmWindow(context),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(3),
    );
  }

  AlertDialog showSignOutConfirmWindow(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            //todo: implement!
            Navigator.pop(context);
          },
          child: const Text('Logout', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
