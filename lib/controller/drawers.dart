import 'package:flutter/material.dart';
import 'package:toto_android/views/boardview.dart';
import 'package:toto_android/controller/controller.dart';
import 'package:toto_android/model/globals.dart';
import 'package:toto_android/views/signup.dart';
import 'package:toto_android/model/textstyles.dart';

import '../api/api.dart';
import '../api/board.dart';
import '../views/login.dart';
import '../views/mainview.dart';

class TotoDrawers {
  static Drawer regularDrawer(BuildContext context, String username) => Drawer(
        width: MediaQuery.of(context).size.width * .6,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 100),
          children: [
            drawerHeader(Icons.person, username, context),
            listTile('Home', Icons.home, context, const MainPage()),
            getBoardTiles('Boards', Icons.burst_mode, context),
            Visibility(
              visible: !Globals.isLogged,
              child: listTile(
                'Log In',
                Icons.login,
                context,
                const LoginPage(),
              ),
            ),
            Visibility(
              visible: !Globals.isLogged,
              child: listTile(
                'Sign up',
                Icons.app_registration_rounded,
                context,
                const SignUpPage(),
              ),
            ),
            Visibility(
              visible: Globals.isLogged,
              child: logOut(
                'Log out',
                Icons.logout,
                context,
              ),
            ),
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

  static ListTile logOut(String title, IconData icon, BuildContext context) =>
      ListTile(
        title: Text(title),
        leading: Icon(icon),
        onTap: () {
          TotoController.LoggedOut();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Text('Successfully logged out'),
              ),
            ),
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        }
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
              if (snapshot.connectionState == ConnectionState.waiting) {
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
        child: Center(
          child: Text(
            name,
            style: TotoTextStyles.bodyLarge(context),
          ),
        ),
      );
}
