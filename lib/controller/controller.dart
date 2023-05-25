import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toto_android/model/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:toto_android/model/colors.dart';
import 'package:toto_android/model/globals.dart';
import 'package:toto_android/model/textstyles.dart';
import 'package:toto_android/views/image.dart';
import 'package:toto_android/views/mainview.dart';
import 'package:toto_android/views/postview.dart';
import 'package:toto_android/views/boardview.dart';
import 'package:toto_android/controller/api.dart';
import 'package:toto_android/model/board.dart';
import 'package:toto_android/model/comment.dart';
import 'package:toto_android/model/post.dart';

import '../model/strings.dart';

/// The main controller of the application
class TotoController {
  /// Returns the header given its destination and widget
  static Padding getHeader(BuildContext context, String destinationName,
      StatefulWidget statefulWidget) {
    return Padding(
      padding: EdgeInsets.all(Sizes.appBarPadding),
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
                builder: (context) => const MainPage(),
              ),
            ),
          ),
          SvgPicture.asset(Globals.logoSvgPath, height: Sizes.svgHeight),
          InkWell(
            child: Text(
              destinationName,
              style: TotoTextStyles.labelMedium(context),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => statefulWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the header of a Board Page given its destination and widget
  static Padding getBoardHeader(Board board, BuildContext context,
      String destinationName, StatefulWidget statefulWidget) {
    return Padding(
      padding: EdgeInsets.all(Sizes.appBarPadding),
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
          SvgPicture.asset(Globals.logoSvgPath, height: Sizes.svgHeight),
          InkWell(
            child: Text(
              destinationName,
              style: TotoTextStyles.labelMedium(context),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => statefulWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns a button for both accesses and calls [TotoController.signUp] or [TotoController.logIn]
  static Positioned buildAccessButton(
      BuildContext context,
      String buttonText,
      TextEditingController usernameController,
      TextEditingController? emailController,
      TextEditingController passwordController,
      TextEditingController? confirmPasswordController,
      isSignUp) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: Sizes.zero,
      right: Sizes.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.accessButtonPaddingHorizontal,
            vertical: Sizes.accessButtonPaddingVertical),
        child: MaterialButton(
          onPressed: () => isSignUp
              ? signUp(
                  usernameController.text,
                  emailController!.text,
                  passwordController.text,
                  confirmPasswordController!.text,
                  context,
                )
              : logIn(
                  usernameController.text, passwordController.text, context),
          color: TotoColors.primary,
          child: Text(
            buttonText,
            style: TotoTextStyles.labelLarge(context),
          ),
        ),
      ),
    );
  }

  /// Renders the Post widget with the submitted data
  static Card buildPost(
      BuildContext context,
      Post post,
      VideoPlayerController? controller,
      Future<void>? initializeVideoPlayerFuture) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.postBorderRadius),
      ),
      margin: EdgeInsets.symmetric(
          vertical: Sizes.postMarginVertical,
          horizontal: Sizes.postMarginHorizontal),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostViewPage(post: post),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(Sizes.postPadding),
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
                        padding: EdgeInsets.fromLTRB(Sizes.zero, Sizes.zero,
                            Sizes.postDataPadding, Sizes.zero),
                        child: Title(
                          color: TotoColors.textColor,
                          child: Text(
                            '${Strings.no}${post.id} ${post.date} ${post.filename}',
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
                      initializeVideoPlayerFuture),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes.postContentPaddingHorizontal,
                        vertical: Sizes.postContentPaddingVertical),
                    child: Text(
                      post.content,
                      maxLines: Globals.postContentMaxLines,
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

  /// Returns an icon with the number of comments of that Post
  static Widget countComments(BuildContext context, post) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          post.comments.length.toString(),
          style: TotoTextStyles.labelMedium(context),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.postCommentsNumberPaddingHorizontal),
          child: Icon(
            Icons.comment_rounded,
            color: TotoColors.primary,
            size: Sizes.commentIconHeight,
          ),
        ),
      ],
    );
  }

  /// Builds the Media for a Post, calls for [TotoController.isFileVideo] to call either [TotoController.buildMediaVideo] or [TotoController.buildMediaImage]
  static Widget buildMedia(
      BuildContext context,
      String mediaUri,
      VideoPlayerController? controller,
      Future<void>? initializeVideoPlayerFuture) {
    if (isFileVideo(mediaUri)) {
      controller = VideoPlayerController.network(
          '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_VIDEOS}$mediaUri');
      initializeVideoPlayerFuture = controller.initialize();
      return buildMediaVideo(initializeVideoPlayerFuture, controller);
    } else {
      return buildMediaImage(mediaUri, context);
    }
  }

  /// Builds the Media for a Comment, calls for [TotoController.isFileVideo] to call either [TotoController.buildMediaVideo] or [TotoController.buildMediaImage]
  static Widget buildCommentMedia(
      BuildContext context,
      Comment post,
      VideoPlayerController? controller,
      Future<void>? initializeVideoPlayerFuture) {
    if (isFileVideo(post.filename)) {
      controller = VideoPlayerController.network(
          '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_VIDEOS}${post.filename}');
      initializeVideoPlayerFuture = controller.initialize();
      return buildMediaVideo(initializeVideoPlayerFuture, controller);
    } else {
      return buildMediaImage(post.filename, context);
    }
  }

  /// Renders the video given the filename, retrieving it from the server
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

  /// Renders the image given the filename, retrieving it from the server
  static InkWell buildMediaImage(String mediaUri, BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(Sizes.postImagePadding),
        child: FadeInImage.assetNetwork(
          image:
              '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_IMAGES}$mediaUri',
          placeholder: Globals.loadingGifPath,
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePage(
              url:
                  '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.API_IMAGES}$mediaUri'),
        ),
      ),
    );
  }

  /// Builds the comments of a Post, calling [TotoController.buildMainPost] and consequently their comments with [Toto.buildComment]
  static Widget buildPostComments(
      BuildContext context,
      Post post,
      VideoPlayerController controller,
      Future<void> initializeVideoPlayerFuture,
      Function(String newTitle) setResponseTo) {
    List<Widget> children = [
      buildMainPost(context, post, controller, initializeVideoPlayerFuture,
          setResponseTo),
    ];
    for (var comment in post.comments) {
      children.add(TotoController.buildComment(context, comment, controller,
          initializeVideoPlayerFuture, setResponseTo));
    }
    return Column(
      children: children,
    );
  }

  /// Calls [controller/Api.getAllPostsByDate] On a successful response builds every post of the server chronologically ascendant. While loading it shows a CircularProgressIndicator. On a failure response it displays an Icon that onTap tries again.
  static FutureBuilder<List<Post>> buildGeneralFeed(
      VideoPlayerController controller,
      Future<void> initializeVideoPlayerFuture) {
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
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: InkWell(
                    child: Icon(
                      Icons.update,
                      size: Sizes.iconRetryConnectionSize,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              for (var post in snapshot.data!) {
                children.add(TotoController.buildPost(
                    context, post, controller, initializeVideoPlayerFuture));
              }
              return Column(
                children: children,
              );
            }
          default:
            return Center(child: Text(Strings.unhandledStateMsg));
        }
      },
    );
  }

  /// Calls [controller/Api.getPostsFromBoard] On a successful response builds every post of the asked Board. While loading it shows a CircularProgressIndicator. On a failure response it displays an Icon that onTap tries again.
  static FutureBuilder<List<Post>> buildBoardFeed(
      Board board,
      VideoPlayerController controller,
      Future<void> initializeVideoPlayerFuture) {
    Future<List<Post>> myData = Api.getPostsFromBoard(board.collectionName);
    return FutureBuilder<List<Post>>(
      future: myData,
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
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: InkWell(
                    child: Icon(
                      Icons.update,
                      size: Sizes.iconRetryConnectionSize,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BoardPage(board: board),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              for (var post in snapshot.data!) {
                children.add(TotoController.buildPost(
                    context, post, controller, initializeVideoPlayerFuture));
              }
              return Column(
                children: children,
              );
            }
          default:
            return Text(Strings.unhandledStateMsg);
        }
      },
    );
  }

  /// Whether the file type is a video
  static bool isFileVideo(String filename) {
    return filename.endsWith('.mp4') || filename.endsWith('.mkv');
  }

  /// Whether the Post has media
  static bool hasMediaPost(Post post) {
    return post.filename != '';
  }

  /// Whether the comment has media
  static bool hasMediaComment(Comment comment) {
    return comment.filename != '';
  }

  /// Renders the Comment widget with the submitted data
  static Widget buildComment(
      BuildContext context,
      Comment comment,
      controller,
      initializeVideoPlayerFuture,
      Function(String newResponseTo) setResponseTo) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.postBorderRadius),
        ),
        margin: EdgeInsets.symmetric(
            vertical: Sizes.postMarginVertical,
            horizontal: Sizes.postMarginVertical),
        child: Padding(
          padding: EdgeInsets.all(Sizes.postPadding),
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
                  padding: EdgeInsets.symmetric(
                      vertical: Sizes.postContentPaddingVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Id, date and filename of the post
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(Sizes.zero, Sizes.zero,
                              Sizes.postDataPadding, Sizes.zero),
                          child: Title(
                            color: TotoColors.textColor,
                            child: Text(
                              '${Strings.no}${comment.id} ${comment.date} ${comment.filename}',
                              style: TotoTextStyles.labelSmall(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Sizes.postImagePadding),
                  child: Row(
                    children: [
                      Text(
                        '${Strings.responseToPrefix}${comment.responseTo}',
                        style: TotoTextStyles.bodyLarge(context),
                      ),
                    ],
                  ),
                ),
                //File of the post
                if (hasMediaComment(comment))
                  buildMedia(context, comment.filename, controller,
                      initializeVideoPlayerFuture),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes.postContentPaddingHorizontal,
                        vertical: Sizes.postContentPaddingVertical),
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

  /// Renders the Post widget with the submitted data on the PostViewPage
  static buildMainPost(
      BuildContext context,
      Post post,
      VideoPlayerController controller,
      Future<void> initializeVideoPlayerFuture,
      Function(String newResponseTo) setResponseTo) {
    return InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.postBorderRadius),
          ),
          margin: EdgeInsets.symmetric(
              vertical: Sizes.postMarginVertical,
              horizontal: Sizes.postMarginHorizontal),
          child: Padding(
            padding: EdgeInsets.all(Sizes.postPadding),
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
                          padding: EdgeInsets.fromLTRB(Sizes.zero, Sizes.zero,
                              Sizes.postDataPadding, Sizes.zero),
                          child: Title(
                            color: TotoColors.textColor,
                            child: Text(
                              '${Strings.no}${post.id} ${post.date} ${post.filename}',
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
                        initializeVideoPlayerFuture),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.postContentPaddingHorizontal,
                          vertical: Sizes.postContentPaddingVertical),
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

  /// Whether the media type of the file is in the accepted types list
  static bool checkFileType(String filename) => Globals.MEDIA_TYPES
      .where((element) => filename.endsWith(element))
      .isNotEmpty;

  /// Checks if the parameters are correct
  ///
  /// On a successful try it calls [Api.createUser], calls [TotoController.loggedIn] and returns
  /// a Snack bar notification.
  /// On a failure try it returns a Snack bar notification with the error.
  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      signUp(String username, String email, String password,
          String confirmPassword, BuildContext context) async {
    String msg = Strings.unknownErrorMsg;
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      msg = Strings.askRequestedFieldsMsg;
    } else if (password != confirmPassword) {
      msg = Strings.notMatchingPasswordMsg;
    } else if (!checkEmail(email)) {
      msg = Strings.emailInvalidMsg;
    } else if (password.length < Globals.passwordMinLenght) {
      msg = Strings.passwordTooShortMsg;
    } else {
      int response = await Api.createUser(username, email, password);
      if (response == HttpStatus.badRequest) {
        msg = '${Strings.usernameMsg}$username${Strings.isAlreadyTakenMsg}';
      } else if (response == HttpStatus.found) {
        msg = Strings.userCreatedMsg;
        loggedIn(username, context);
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

  /// Whether the email given is coherent
  static bool checkEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  /// Checks if the parameters are correct
  ///
  /// On a successful try it calls [Api.logIn] and waits for the response
  /// to accept or deny the login, and calls [TotoController.loggedIn].
  /// On a failure try it returns a Snack bar notification with the error.
  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      logIn(
    String username,
    String password,
    BuildContext context,
  ) async {
    String msg = '';
    if (username.isEmpty || password.isEmpty) {
      msg = Strings.askRequestedFieldsMsg;
    } else {
      int response = await Api.logIn(username, password);
      if (response == HttpStatus.unauthorized) {
        msg = Strings.failedLoginMsg;
      } else if (response == HttpStatus.found) {
        await loggedIn(username, context);
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

  /// Writes in the device the username and sets true the loggedIn bool
  static Future<void> loggedIn(String username, BuildContext context) async {
    Globals.username = username;
    Globals.isLogged = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', true);
    await prefs.setString('username', username);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainPage()));
  }

  /// Calls [Api.createComment] and returns a Snack bar with the response.
  static void setComment(
    Post post,
    String responseTo,
    String username,
    String content,
    File file,
    BuildContext context,
  ) async {
    String msg = Strings.unknownErrorMsg;
    int response = await Api.createComment(
      post.id!,
      post.collectionName!,
      responseTo,
      username,
      content,
      file,
    );
    switch (response) {
      case HttpStatus.found:
        msg = Strings.successSetComment;
        break;
      case HttpStatus.notFound:
        msg = Strings.notFoundPostId;
        break;
      case HttpStatus.unsupportedMediaType:
        msg =
            '${Strings.unsupportedMediaPost}${Globals.MEDIA_TYPES.join(', ')}';
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

  /// Erases the data stored in the device and resets the variables of username
  /// and loggedIn
  static void loggedOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Globals.username = '';
    Globals.isLogged = false;
    prefs.remove('loggedIn');
    prefs.remove('username');
  }
}
