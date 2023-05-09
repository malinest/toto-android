import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:toto_android/colors.dart';
import 'package:toto_android/drawers.dart';
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
            expandedHeight: 200,
            floating: true,
            pinned: true,
            backgroundColor: TotoColors.primary,
            leading: const Icon(
              Icons.keyboard_backspace,
              color: TotoColors.contrastColor,
            ),
            flexibleSpace: _FormPostSpace(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
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
    );
  }

  Card buildPost(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                    image: NetworkImage(
                        'https://pbs.twimg.com/semantic_core_img/1338905208802271232/OE5Qq8L5?format=jpg&name=small')),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque. Duis vulputate commodo lectus, ac blandit elit tincidunt id. Sed rhoncus, tortor sed a sidsssi',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FormPostSpace extends StatelessWidget {
  const _FormPostSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Opacity(
                  opacity: 1 - opacity,
                  child: Text(
                    'Technology',
                    style: TotoTextStyles.displayLarge(context),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: opacity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 35.0, 10.0, 0.0),
                    child: Column(
                      children: [
                        Title(
                          color: TotoColors.textColor,
                          child: Text(
                            'Create Post',
                            style: TotoTextStyles.displayLarge(context),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 20,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Post title',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 0,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Content title',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
