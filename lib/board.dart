import 'package:flutter/material.dart';
import 'package:toto_android/colors.dart';
import 'package:toto_android/drawers.dart';
import 'package:toto_android/image.dart';
import 'package:toto_android/postform.dart';
import 'package:toto_android/postview.dart';
import 'package:toto_android/textstyles.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TotoColors.secondary,
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
                      buildPost(context),
                      buildPost(context),
                      buildPost(context),
                      buildPost(context),
                      buildPost(context),
                      buildPost(context),
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

  Card buildPost(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostViewPage(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Title(
                      color: TotoColors.textColor,
                      child: Text(
                        'Has Elon Musk gone too far?',
                        style: TotoTextStyles.displayMedium(context),
                      ),
                    ),
                    Title(
                      color: TotoColors.textColor,
                      child: Text(
                        'JordiSoto',
                        style: TotoTextStyles.labelMedium(context),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Title(
                      color: TotoColors.textColor,
                      child: Text(
                        'No.4 23-05-2023 6:39 juanymedio.jpg',
                        style: TotoTextStyles.labelSmall(context),
                      ),
                    ),
                    Title(
                      color: TotoColors.textColor,
                      child: Text(
                        '14 Comments',
                        style: TotoTextStyles.labelSmall(context),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                        image: NetworkImage(
                            'https://pbs.twimg.com/semantic_core_img/1338905208802271232/OE5Qq8L5?format=jpg&name=small')),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImagePage(
                          url:
                              'https://pbs.twimg.com/semantic_core_img/1338905208802271232/OE5Qq8L5?format=jpg&name=small'),
                    ),
                  ),
                ),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque. Duis vulputate commodo lectus, ac blandit elit tincidunt id. Sed rhoncus, tortor sed a sidsssi',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
