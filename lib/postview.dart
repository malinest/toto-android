import 'package:flutter/material.dart';

import 'utils.dart';

class PostViewPage extends StatefulWidget {
  const PostViewPage({Key? key}) : super(key: key);

  @override
  State<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        TotoUtils.buildPost(context),
                        TotoUtils.buildPostComment(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
