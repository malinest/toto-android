import 'package:flutter/material.dart';
import 'package:toto_android/boardview.dart';
import 'package:toto_android/colors.dart';
import 'package:video_player/video_player.dart';
import 'api/api.dart';
import 'api/post.dart';
import 'image.dart';
import 'postview.dart';
import 'textstyles.dart';
import 'package:flutter_svg/svg.dart';

class TotoController {
  static Padding getHeader(
      BuildContext context, String destinationName, StatefulWidget sw) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: const Icon(
              Icons.keyboard_backspace_sharp,
              color: TotoColors.primary,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardPage(),
              ),
            ),
          ),
          SvgPicture.asset('assets/logo.svg', height: 20),
          InkWell(
            child: Text(
              destinationName,
              style: TotoTextStyles.labelMedium(context),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => sw,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Positioned buildAccessButton(
      BuildContext context, String text, Function function) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: MaterialButton(
          onPressed: () => null,
          color: TotoColors.primary,
          child: Text(
            text,
            style: TotoTextStyles.labelLarge(context),
          ),
        ),
      ),
    );
  }

  static Card buildPost(BuildContext context, Post post, VideoPlayerController? controller, Future<void>? initializeVideoPlayerFuture, Function? callback) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostViewPage(post: post),
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
                    //Title of the post
                    Expanded(
                      child: Title(
                        color: TotoColors.textColor,
                        child: Text(
                          post.title,
                          style: TotoTextStyles.displayMedium(context),
                        ),
                      ),
                    ),
                    //Author of the post
                    Title(
                      color: TotoColors.textColor,
                      child: Text(
                        post.username,
                        style: TotoTextStyles.labelMedium(context),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Id, date and filename of the post
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                        child: Title(
                          color: TotoColors.textColor,
                          child: Text(
                            'No.${post.id} ${post.date} ${post.filename}',
                            style: TotoTextStyles.labelSmall(context),
                          ),
                        ),
                      ),
                    ),
                    //Number of comments
                    Title(
                      color: TotoColors.textColor,
                      child: Text(
                        '14 Comments',
                        style: TotoTextStyles.labelSmall(context),
                      ),
                    ),
                  ],
                ),
                //File of the post
                if (hasMedia(post)) buildPostMedia(context, post, controller, initializeVideoPlayerFuture, callback),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5.0),
                    child: Text(
                      post.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildPostMedia(BuildContext context, Post post, VideoPlayerController? controller, Future<void>? initializeVideoPlayerFuture, Function? callback) {
    if (isFileVideo(post.filename)) {
      return Text('video');
    } else {
      return buildMediaImage(post, context);
    }
  }

  static InkWell buildMediaImage(Post post, BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(
            image: NetworkImage(
                'http://5.196.29.178:5000/static/images/${post.filename}')),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePage(
              url: 'http://5.196.29.178:5000/static/images/${post.filename}'),
        ),
      ),
    );
  }
/**
  static Widget buildMediaVideo(Post post, BuildContext context, VideoPlayerController? controller, Future<void>? initializeVideoPlayerFuture, Function? callback) {

    controller = VideoPlayerController.network('http://5.196.29.178:5000/static/videos/${post.filename}')
      ..addListener(() => callback!(() {}))
    ..initialize().then((_) => controller!.play());
    return FutureBuilder(
      future: initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(aspectRatio: controller!.value.aspectRatio,child: VideoPlayer(controller!),);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
    **/

  static Card buildPostComment(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
                      'No.4 23-05-2023 6:39 juanymedio.jpg',
                      style: TotoTextStyles.labelSmall(context),
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
                      'OP',
                      style: TotoTextStyles.labelMedium(context),
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
                          'https://pngimg.com/uploads/glass/wineglass_PNG2872.png')),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImagePage(
                        url:
                            'https://pngimg.com/uploads/glass/wineglass_PNG2872.png'),
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
    );
  }

  static FutureBuilder<List<Post>> buildGeneralFeed(VideoPlayerController controller, Future<void> initializeVideoPlayerFuture, Function? callback) {
    return FutureBuilder<List<Post>>(
      future: getAllPostsByDate(),
      builder: (context, snapshot) {
        List<Widget> children = [];
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                  child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              snapshot.data!.forEach((post) {
                children.add(TotoController.buildPost(context, post, controller, initializeVideoPlayerFuture, callback));
              });
              return Column(
                children: children,
              );
            }
          default:
            return Text('Unhandle State');
        }
      },
    );
  }

  static bool isFileVideo(String filename) {
    return filename.endsWith('.mp4') || filename.endsWith('.mkv');
  }

  static bool hasMedia(Post post) {
    return post.filename != '';
  }
}
