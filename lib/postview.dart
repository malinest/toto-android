import 'package:flutter/material.dart';
import 'api/post.dart';
import 'controller.dart';

class PostViewPage extends StatefulWidget {
  final Post post;

  const PostViewPage({Key? key, required this.post}) : super(key: key);

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
                        TotoController.buildPost(context, widget.post, null, null, null),
                        TotoController.buildPostComment(context),
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
