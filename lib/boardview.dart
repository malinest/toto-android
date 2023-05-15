import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart';
import 'drawers.dart';
import 'postform.dart';
import 'textstyles.dart';
import 'controller.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('');
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

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
                  child: TotoController.buildGeneralFeed(_controller, _initializeVideoPlayerFuture, super.setState),
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
