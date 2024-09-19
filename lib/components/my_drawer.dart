import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // logout method
  void logout() {
    // get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer header: logo
              DrawerHeader(
                child: Icon(
                  Icons.chat,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              // home tile
              MyListTile(
                icon: Icons.home_filled,
                text: "Home",
                onTap: () {
                  // pop the drawer
                  Navigator.pop(context);
                },
              ),

              // settings tile
              MyListTile(
                icon: Icons.settings,
                text: "Settings",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings_page');
                },
              ),
            ],
          ),

          // logout tile
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: MyListTile(
              icon: Icons.logout,
              text: "Logout",
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
