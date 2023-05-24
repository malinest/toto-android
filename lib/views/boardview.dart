import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:toto_android/model/colors.dart';
import 'package:toto_android/model/globals.dart';
import 'package:toto_android/model/textstyles.dart';
import 'package:toto_android/views/mainview.dart';
import 'package:toto_android/views/postform.dart';
import 'package:toto_android/model/board.dart';
import 'package:toto_android/controller/drawers.dart';
import 'package:toto_android/controller/controller.dart';

class BoardPage extends StatefulWidget {
  final Board board;

  const BoardPage({Key? key, required this.board}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(Globals.videoPlayerPlaceHolder);
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
      drawer: TotoDrawers.regularDrawer(context, Globals.username),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            floating: true,
            backgroundColor: TotoColors.primary,
            leading: InkWell(
              child: const Icon(
                Icons.keyboard_backspace,
                color: TotoColors.contrastColor,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
              ),
            ),
            title: Text(
              widget.board.name,
              style: TotoTextStyles.displayLarge(context),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  width: double.infinity,
                  child: TotoController.buildBoardFeed(
                      widget.board, _controller, _initializeVideoPlayerFuture),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: Globals.isLogged,
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostFormPage(
                      board: widget.board,
                    )),
          ),
          backgroundColor: TotoColors.contrastColor,
          child: const Icon(
            Icons.create,
          ),
        ),
      ),
    );
  }
}
