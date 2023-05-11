import 'package:flutter/material.dart';
import 'package:toto_android/api/post.dart';
import 'colors.dart';
import 'drawers.dart';
import 'postform.dart';
import 'textstyles.dart';
import 'utils.dart';
import 'api/api.dart';

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
                  child: FutureBuilder<List<Post>>(
                      future: getAllPostsByDate(),
                      builder: (context, snapshot) {
                        List<Widget> children = [];
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              snapshot.data!.forEach((post) {
                                children
                                    .add(TotoUtils.buildPost(context, post));
                              });
                              return Column(
                                children: children,
                              );
                            }
                          default:
                            return Text('Unhandle State');
                        }
                      }),
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
