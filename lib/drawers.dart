import 'package:flutter/material.dart';
import 'package:toto_android/signup.dart';
import 'package:toto_android/textstyles.dart';

import 'login.dart';

class TotoDrawers {
  static Drawer regularDrawer(BuildContext context) => Drawer(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            drawerHeader(Icons.person, 'John Doe', context),
            listTile('Home', Icons.home, context, const LoginPage()),
            listTile('Search', Icons.search, context, const SignUpPage()),
            expansionTile('Following', Icons.bookmarks, context),
            listTile('My Boards', Icons.burst_mode, context, const LoginPage()),
            listTile('Settings', Icons.settings, context, const LoginPage()),
            listTile('Log In', Icons.login, context, const LoginPage())
          ],
        ),
      );

  static ListTile listTile(String title, IconData icon, BuildContext context, StatefulWidget sw) =>
      ListTile(
        title: Text(title),
        leading: Icon(icon),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => sw)),
      );

  static ExpansionTile expansionTile(String title, IconData icon, BuildContext context) =>
      ExpansionTile(
        title: Text(title),
        leading: Icon(icon),
        children: [
          listTile('Anime', Icons.accessible, context, LoginPage()),
          listTile('Technology', Icons.adb, context, LoginPage()),
          listTile('Green Texts', Icons.graphic_eq, context, LoginPage()),
        ],
      );

  static DrawerHeader drawerHeader(IconData url, String name, BuildContext context) => DrawerHeader(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(25.0),
          child: CircleAvatar(
              radius: 30,
              child: Icon(url),
          ),
        ),
        Text(name, style: TotoTextStyles.bodyLarge(context),),
      ],
    ),
  );
}
