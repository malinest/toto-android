import 'package:flutter/material.dart';
import 'package:toto_android/boardview.dart';
import 'package:toto_android/signup.dart';
import 'package:toto_android/textstyles.dart';

import 'api/api.dart';
import 'api/board.dart';
import 'login.dart';
import 'mainview.dart';

class TotoDrawers {
  static Drawer regularDrawer(BuildContext context) => Drawer(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            drawerHeader(Icons.person, 'John Doe', context),
            listTile('Home', Icons.home, context, const MainPage()),
            listTile('Search', Icons.search, context, const SignUpPage()),
            getBoardTiles('Boards', Icons.burst_mode, context),
            listTile('Settings', Icons.settings, context, const LoginPage()),
            listTile('Log In', Icons.login, context, const LoginPage())
          ],
        ),
      );

  static ListTile listTile(String title, IconData icon, BuildContext context,
          StatefulWidget sw) =>
      ListTile(
        title: Text(title),
        leading: Icon(icon),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => sw)),
      );

  static ListTile listBoardTile(
          String title, BuildContext context, StatefulWidget sw) =>
      ListTile(
        title: Text(title),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => sw)),
      );

  static FutureBuilder<List<Board>> getBoardTiles(
    String title,
    IconData icon,
    BuildContext context,
  ) =>
      FutureBuilder(
          future: Api.getAllBoards(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              if (snapshot.connectionState == ConnectionState.waiting){
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              List<Widget> children = [];
              for (var board in snapshot.requireData) {
                children.add(listBoardTile(
                    board.name, context, BoardPage(board: board)));
              }
              return ExpansionTile(
                title: Text(title),
                leading: Icon(icon),
                children: children,
              );
            }
          });

  static DrawerHeader drawerHeader(
          IconData url, String name, BuildContext context) =>
      DrawerHeader(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(25.0),
              child: CircleAvatar(
                radius: 30,
                child: Icon(url),
              ),
            ),
            Text(
              name,
              style: TotoTextStyles.bodyLarge(context),
            ),
          ],
        ),
      );
}
