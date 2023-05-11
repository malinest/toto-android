import 'package:flutter/material.dart';
import 'package:toto_android/colors.dart';
import 'package:toto_android/drawers.dart';
import 'package:toto_android/postform.dart';
import 'package:toto_android/textstyles.dart';
import 'package:toto_android/utils.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: TotoDrawers.regularDrawer(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: TotoColors.primary,
            leading: const Icon(
              Icons.keyboard_backspace,
              color: TotoColors.contrastColor,
            ),
            title: Text(
              'Technology',
              style: TotoTextStyles.displayLarge(context),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      TotoUtils.buildPost(context),
                      TotoUtils.buildPost(context),
                      TotoUtils.buildPost(context),
                      TotoUtils.buildPost(context),
                      TotoUtils.buildPost(context),
                      TotoUtils.buildPost(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostFormPage()),
        ),
        backgroundColor: TotoColors.contrastColor,
        child: const Icon(
          Icons.create,
        ),
      ),
    );
  }
}
