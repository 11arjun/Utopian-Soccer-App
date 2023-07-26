import 'package:flutter/material.dart';
import 'package:utopiansoccer/Pages/team_screen.dart';
import 'package:utopiansoccer/Pages/notification_screen.dart';
import 'package:utopiansoccer/Pages/setting_screen.dart';
import 'package:utopiansoccer/khalti_payment_page.dart';
import 'package:utopiansoccer/login.dart';
import 'package:utopiansoccer/utils/backend_helper.dart';
import 'package:utopiansoccer/welcome.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    return Drawer(
      // returning the drawer and calling from main.dart
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(' Arjun Shrestha'),
            // ignore: prefer_const_constructors
            accountEmail: Text('alexizshrestha11@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/avatar.png",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage(
                  'https://media.istockphoto.com/photos/dramatic-american-football-stadium-picture-id530810426?b=1&k=20&m=530810426&s=170667a&w=0&h=ocKx7cDRsRwUyqmuli_6pDoKht5J0fW4MkjsBVbTgYQ=',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // ListTile(
          //   leading: const Icon(Icons.notifications),
          //   title: const Text('Notifications'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: ((context) => const NotificationScreen()),
          //       ),
          //     );
          //   },
          //   trailing: ClipOval(
          //     child: Container(
          //       color: Colors.red,
          //       width: 20,
          //       height: 20,
          //       child: const Center(
          //         child: Text(
          //           '8',
          //           style: TextStyle(color: Colors.white, fontSize: 12),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.payments),
            title: const Text('Quick Payment'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const KhaltiPaymentPage()),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const Setting()),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              var response = await BackendHelper.instance.logoutUser();
              if (response) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route route) => false,
                );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Logged out Successfully"),
                  backgroundColor: Colors.green,
                  duration: Duration(milliseconds: 1500),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Error: Failed Logging out"),
                  backgroundColor: Colors.red,
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
