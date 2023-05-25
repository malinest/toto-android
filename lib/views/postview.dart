import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:toto_android/model/colors.dart';
import 'package:toto_android/model/textstyles.dart';
import 'package:toto_android/model/post.dart';
import 'package:toto_android/controller/controller.dart';

import '../model/globals.dart';

class PostViewPage extends StatefulWidget {
  final Post post;

  const PostViewPage({Key? key, required this.post}) : super(key: key);

  @override
  State<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final commentController = TextEditingController();
  bool isKeyboardUp = false;
  String responseTo = 'OP';
  File file = File('');
  String filename = '';

  @override
  void initState() {
    super.initState();

    if (widget.post.filename.endsWith('.mp4')) {
      _controller = VideoPlayerController.network(widget.post.filename);
    } else {
      _controller =
          VideoPlayerController.network(Globals.videoPlayerPlaceHolder);
    }

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  /// Builds the Post View Page Widget
  @override
  Widget build(BuildContext context) {
    bool? isAnonymous = false;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          children: [
                            TotoController.buildPostComments(
                                context,
                                widget.post,
                                _controller,
                                _initializeVideoPlayerFuture,
                                setResponseTo),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: Globals.isLogged,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: TotoColors.primary,
                    ),
                  ),
                ),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Visibility(
                      visible: isKeyboardUp,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'In response to ',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: responseTo == widget.post.id.toString()
                                      ? '$responseTo (OP)'
                                      : responseTo,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: TotoColors.textColor,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: filename != '',
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: TotoColors.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  filename,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                InkWell(
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        file = File('');
                                        filename = '';
                                      });
                                    })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isKeyboardUp,
                      child: Row(
                        children: [
                          StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Checkbox(
                                value: isAnonymous,
                                onChanged: (bool? value) => setState(() {
                                      isAnonymous = value;
                                    }));
                          }),
                          Text(
                            'Anonymous',
                            style: TotoTextStyles.labelMedium(context),
                          )
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              maxLines: null,
                              maxLength: 2400,
                              decoration: const InputDecoration(
                                  labelText: 'Comment', counterText: ''),
                              onTap: () => setState(() {
                                isKeyboardUp = true;
                              }),
                            ),
                          ),
                          Visibility(
                            visible: filename == '',
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: InkWell(
                                child: const Icon(
                                  Icons.attach_file,
                                  color: TotoColors.primary,
                                ),
                                onTap: () => searchFile(),
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: InkWell(
                                  child: const Icon(
                                    Icons.send_rounded,
                                    color: TotoColors.primary,
                                  ),
                                  onTap: () {
                                    TotoController.setComment(
                                      widget.post,
                                      responseTo == 'OP'
                                          ? widget.post.id.toString()
                                          : responseTo,
                                      isAnonymous!
                                          ? 'Anonymous'
                                          : Globals.username,
                                      commentController.text,
                                      file,
                                      context,
                                    );
                                    commentController.text = '';
                                    filename = '';
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    isKeyboardUp = false;
                                  })),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Changes the response_to value in the comment created
  setResponseTo(String newTitle) {
    setState(() {
      responseTo = newTitle;
    });
  }

  /// Search for an Image, Video or Gif in the File Explorer
  searchFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: Globals.MEDIA_TYPES);

    if (result != null) {
      File newFile = File(result.files.single.path!);
      if (TotoController.checkFileType(newFile.path)) {
        file = newFile;
        setState(() {
          filename = file.path.split('/').last;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('The file has to be ${Globals.MEDIA_TYPES.join(', ')}'),
        ),
      );
    }
  }
}
