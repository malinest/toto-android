import 'package:flutter/material.dart';
import 'package:toto_android/boardview.dart';
import 'package:toto_android/colors.dart';
import 'package:video_player/video_player.dart';
import 'api/api.dart';
import 'api/board.dart';
import 'api/comment.dart';
import 'api/post.dart';
import 'globals.dart';
import 'image.dart';
import 'mainview.dart';
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
                builder: (context) => MainPage(),
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


  static Padding getBoardHeader(
      Board board,
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
                builder: (context) => BoardPage(board: board),
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

  static Card buildPost(
      BuildContext context,
      Post post,
      VideoPlayerController? controller,
      Future<void>? initializeVideoPlayerFuture,
      Function? callback) {
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
                      child: countComments(context, post),
                    ),
                  ],
                ),
                //File of the post
                if (hasMediaPost(post))
                  buildMedia(context, post.filename, controller,
                      initializeVideoPlayerFuture, callback),
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

  static Widget countComments(BuildContext context, post) {
    int nComments = 0;
    for (var comment in post.comments) {
      nComments++;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          nComments.toString(),
          style: TotoTextStyles.labelMedium(context),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Icon(
            Icons.comment_rounded,
            color: TotoColors.primary,
            size: 20,
          ),
        ),
      ],
    );
  }

  static Widget buildMedia(
      BuildContext context,
      String mediaUri,
      VideoPlayerController? controller,
      Future<void>? initializeVideoPlayerFuture,
      Function? callback) {
    if (isFileVideo(mediaUri)) {
      controller = VideoPlayerController.network(
          '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_VIDEOS}${mediaUri}');
      initializeVideoPlayerFuture = controller.initialize();
      return buildMediaVideo(initializeVideoPlayerFuture, controller);
    } else {
      return buildMediaImage(mediaUri, context);
    }
  }

  static Widget buildCommentMedia(
      BuildContext context,
      Comment post,
      VideoPlayerController? controller,
      Future<void>? initializeVideoPlayerFuture,
      Function? callback) {
    if (isFileVideo(post.filename)) {
      controller = VideoPlayerController.network(
          '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_VIDEOS}${post.filename}');
      initializeVideoPlayerFuture = controller.initialize();
      return buildMediaVideo(initializeVideoPlayerFuture, controller);
    } else {
      return buildMediaImage(post.filename, context);
    }
  }

  static FutureBuilder<void> buildMediaVideo(Future<void> initializeVideoPlayerFuture, VideoPlayerController? controller) {
    return FutureBuilder(
      future: initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          controller!.setLooping(true);
          return Column(
            children: [
              InkWell(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
                onTap: () => controller.value.isPlaying
                    ? controller.pause()
                    : controller.play(),
              ),
              VideoProgressIndicator(
                controller,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: TotoColors.contrastColor,
                  bufferedColor: Colors.grey,
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  static InkWell buildMediaImage(String mediaUri, BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(
            image: NetworkImage(
                '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_IMAGES}${mediaUri}')),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePage(
              url:
                  '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_IMAGES}${mediaUri}'),
        ),
      ),
    );
  }

  static Widget buildPostComments(
      BuildContext context,
      Post post,
      VideoPlayerController controller,
      Future<void> initializeVideoPlayerFuture,
      Function? callback) {
    List<Widget> children = [
      buildMainPost(
          context, post, controller, initializeVideoPlayerFuture, callback),
    ];
    for (var comment in post.comments) {
      children.add(TotoController.buildComment(
          context, comment, controller, initializeVideoPlayerFuture, callback));
    }
    return Column(
      children: children,
    );
  }

  static FutureBuilder<List<Post>> buildGeneralFeed(
      VideoPlayerController controller,
      Future<void> initializeVideoPlayerFuture,
      Function? callback) {
    return FutureBuilder<List<Post>>(
      future: getAllPostsByDate(),
      builder: (context, snapshot) {
        List<Widget> children = [];
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              for (var post in snapshot.data!) {
                children.add(TotoController.buildPost(context, post, controller,
                    initializeVideoPlayerFuture, callback));
              }
              return Column(
                children: children,
              );
            }
          default:
            return const Text('Unhandled State');
        }
      },
    );
  }

  static FutureBuilder<List<Post>> buildBoardFeed(
      String collectionName,
      VideoPlayerController controller,
      Future<void> initializeVideoPlayerFuture,
      Function? callback) {
    return FutureBuilder<List<Post>>(
      future: getPostsFromBoard(collectionName),
      builder: (context, snapshot) {
        List<Widget> children = [];
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              for (var post in snapshot.data!) {
                children.add(TotoController.buildPost(context, post, controller,
                    initializeVideoPlayerFuture, callback));
              }
              return Column(
                children: children,
              );
            }
          default:
            return const Text('Unhandled State');
        }
      },
    );
  }

  static bool isFileVideo(String filename) {
    return filename.endsWith('.mp4') || filename.endsWith('.mkv');
  }

  static bool hasMediaPost(Post post) {
    return post.filename != '';
  }

  static bool hasMediaComment(Comment comment) {
    return comment.filename != '';
  }

  static Widget buildComment(BuildContext context, Comment comment, controller,
      initializeVideoPlayerFuture, callback) {
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
                  //Author of the post
                  Title(
                    color: TotoColors.textColor,
                    child: Text(
                      comment.username,
                      style: TotoTextStyles.labelMedium(context),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Id, date and filename of the post
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                        child: Title(
                          color: TotoColors.textColor,
                          child: Text(
                            'No.${comment.id} ${comment.date} ${comment.filename}',
                            style: TotoTextStyles.labelSmall(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //File of the post
              if (hasMediaComment(comment))
                buildMedia(context, comment.filename, controller,
                    initializeVideoPlayerFuture, callback),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  child: Text(
                    comment.content,
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
    );
  }

  static buildMainPost(
      BuildContext context,
      Post post,
      VideoPlayerController controller,
      Future<void> initializeVideoPlayerFuture,
      Function? callback) {
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
                    child: countComments(context, post),
                  ),
                ],
              ),
              //File of the post
              if (hasMediaPost(post))
                buildMedia(context, post.filename, controller,
                    initializeVideoPlayerFuture, callback),
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
    );
  }
}
