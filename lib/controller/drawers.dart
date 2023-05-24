import 'package:flutter/material.dart';
import 'package:toto_android/model/globals.dart';
import 'package:toto_android/model/sizes.dart';
import 'package:toto_android/model/strings.dart';
import 'package:toto_android/model/textstyles.dart';
import 'package:toto_android/views/boardview.dart';
import 'package:toto_android/views/signup.dart';
import 'package:toto_android/views/login.dart';
import 'package:toto_android/views/mainview.dart';
import 'package:toto_android/controller/controller.dart';
import 'package:toto_android/controller/api.dart';
import 'package:toto_android/model/board.dart';

class TotoDrawers {
  /// Builds the Drawer of the app
  static Drawer regularDrawer(BuildContext context, String username) => Drawer(
        width: MediaQuery.of(context).size.width * Sizes.drawerWidth,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: Sizes.drawerPadding),
          children: [
            drawerHeader(Icons.person, username, context),
            listTile(
                Strings.home, Icons.home, context, const MainPage(), false),
            getBoardTiles(Strings.boards, Icons.burst_mode, context),
            Visibility(
              visible: !Globals.isLogged,
              child: listTile(Strings.login, Icons.login, context,
                  const LoginPage(), false),
            ),
            Visibility(
              visible: !Globals.isLogged,
              child: listTile(Strings.signup, Icons.app_registration_rounded,
                  context, const SignUpPage(), false),
            ),
            Visibility(
              visible: Globals.isLogged,
              child: logOut(
                Strings.logout,
                Icons.logout,
                context,
              ),
            ),
          ],
        ),
      );

  /// Builds the elements of the drawer
  static ListTile listTile(String title, IconData? icon, BuildContext context,
      StatefulWidget sw, bool isBoard) {
    if (isBoard) {
      return ListTile(
        title: Text(title),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => sw)),
      );
    }
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) => sw)),
    );
  }

  /// Builds the logout element
  static ListTile logOut(String title, IconData icon, BuildContext context) =>
      ListTile(
          title: Text(title),
          leading: Icon(icon),
          onTap: () {
            TotoController.LoggedOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Text(Strings.successLogOutMsg),
                ),
              ),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          });

  ///
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
              if (snapshot.hasError) {
                return (Text(Strings.failureGetDataMsg));
              }
              List<Widget> children = [];
              for (var board in snapshot.requireData) {
                children.add(listTile(
                    board.name, null, context, BoardPage(board: board), false));
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
