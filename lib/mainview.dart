import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart';
import 'drawers.dart';
import 'controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final _key = GlobalKey<ScaffoldState>();

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
      key: _key,
      backgroundColor: Colors.grey[100],
      drawer: TotoDrawers.regularDrawer(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            floating: true,
            backgroundColor: TotoColors.primary,
            leadingWidth: double.infinity,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onTap: () => _key.currentState!.openDrawer(),
                  ),
                  SvgPicture.asset('assets/logo.svg', height: 20),
                  Container(width: 15,)
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  width: double.infinity,
                  child: TotoController.buildGeneralFeed(_controller,
                      _initializeVideoPlayerFuture, super.setState),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
