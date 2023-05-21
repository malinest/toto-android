import 'dart:io';

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

  static Padding getBoardHeader(Board board, BuildContext context,
      String destinationName, StatefulWidget sw) {
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

  static Positioned buildAccessButtonSignUp(
    BuildContext context,
    String text,
    TextEditingController usernameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
  ) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: MaterialButton(
          onPressed: () => signUp(
            usernameController.text,
            emailController.text,
            passwordController.text,
            confirmPasswordController.text,
            context,
          ),
          color: TotoColors.primary,
          child: Text(
            text,
            style: TotoTextStyles.labelLarge(context),
          ),
        ),
      ),
    );
  }

  static Positioned buildAccessButtonLogIn(
      BuildContext context,
      String text,
      TextEditingController usernameController,
      TextEditingController passwordController) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: MaterialButton(
          onPressed: () =>
              logIn(usernameController.text, passwordController.text, context),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          post.comments.length.toString(),
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
      if (mediaUri.contains('#')) {
        controller = VideoPlayerController.network(
            '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_VIDEOS}$mediaUri');
        initializeVideoPlayerFuture = controller.initialize();
      } else {
        controller = VideoPlayerController.network(
            '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_VIDEOS}$mediaUri');
        initializeVideoPlayerFuture = controller.initialize();
      }
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

  static FutureBuilder<void> buildMediaVideo(
      Future<void> initializeVideoPlayerFuture,
      VideoPlayerController? controller) {
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
      Function? callback,
      Function(String newTitle) setResponseTo) {
    List<Widget> children = [
      buildMainPost(context, post, controller, initializeVideoPlayerFuture,
          callback, setResponseTo),
    ];
    for (var comment in post.comments) {
      children.add(TotoController.buildComment(context, comment, controller,
          initializeVideoPlayerFuture, callback, setResponseTo));
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
      future: Api.getAllPostsByDate(),
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
      future: Api.getPostsFromBoard(collectionName),
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

  static Widget buildComment(
      BuildContext context,
      Comment comment,
      controller,
      initializeVideoPlayerFuture,
      callback,
      Function(String newResponseTo) setResponseTo) {
    return InkWell(
      child: Card(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        '>${comment.responseTo}',
                        style: TotoTextStyles.bodyLarge(context),
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
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () => setResponseTo(comment.id.toString()),
    );
  }

  static buildMainPost(
      BuildContext context,
      Post post,
      VideoPlayerController controller,
      Future<void> initializeVideoPlayerFuture,
      Function? callback,
      Function(String newResponseTo) setResponseTo) {
    return InkWell(
        child: Card(
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
                        textAlign: TextAlign.left,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onTap: () => setResponseTo(post.id.toString()));
  }

  static bool checkFileType(String filename) => Globals.MEDIA_TYPES
      .where((element) => filename.endsWith(element))
      .isNotEmpty;

  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      signUp(String username, String email, String password,
          String confirmPassword, BuildContext context) async {
    String msg = 'Unknown error';
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      msg = "Please fill all fields.";
    } else if (password != confirmPassword) {
      msg = "Passwords doesn't match";
    } else if (!checkEmail(email)) {
      msg = "Email not valid";
    } else if (password.length < 8) {
      msg = "Password must be at least 8 characters long";
    } else {
      int response = await Api.createUser(username, email, password);
      if (response == 400) {
        msg = 'Username $username is already taken';
      } else if (response == 302) {
        msg = 'User created successfully';
        Globals.username = username;
        Globals.isLogged = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Text(msg),
        ),
      ),
    );
  }

  static bool checkEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      logIn(
    String username,
    String password,
    BuildContext context,
  ) async {
    String msg = '';
    if (username.isEmpty || password.isEmpty) {
      msg = "Please fill all fields.";
    } else {
      int response = await Api.logIn(username, password);
      if (response == 401) {
        msg = "Username and password doesn't exists";
      } else if (response == 302) {
        Globals.username = username;
        Globals.isLogged = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Text(msg),
        ),
      ),
    );
  }

  static void setComment(
    Post post,
    String responseTo,
    String username,
    String content,
    File file,
    BuildContext context,
  ) async {
    String msg = 'Unknown error';
    int response = await Api.createComment(
      post.id!,
      post.collectionName!,
      responseTo,
      username,
      content,
      file,
    );
    switch (response) {
      case 302:
        msg = 'Comment published succesfully';
        break;
      case 404:
        msg = 'There is no post that has or contains this id';
        break;
      case 415:
        msg =
            'Invalid file format, only this formats are accepted: ${Globals.MEDIA_TYPES.join(', ')}';
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Text(msg),
        ),
      ),
    );
  }
}
