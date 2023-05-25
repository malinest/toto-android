import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:toto_android/model/colors.dart';
import 'package:toto_android/model/globals.dart';
import 'package:toto_android/model/sizes.dart';
import 'package:toto_android/model/strings.dart';
import 'package:toto_android/model/textstyles.dart';
import 'package:toto_android/views/boardview.dart';
import 'package:toto_android/controller/api.dart';
import 'package:toto_android/model/board.dart';

class PostFormPage extends StatefulWidget {
  final Board board;

  const PostFormPage({Key? key, required this.board}) : super(key: key);

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  File file = File('');
  String filename = '';
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Sizes.postImagePadding),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    buildFormHeader(context),
                    TextField(
                      maxLength: 100,
                      decoration: const InputDecoration(hintText: 'Post title'),
                      controller: titleController,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Sizes.postFormContentMaxHeight),
                      child: TextField(
                        maxLines: null,
                        maxLength: Globals.postFormContentMaxLength,
                        decoration: InputDecoration(
                          hintText: Strings.postContent,
                        ),
                        controller: contentController,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: filename != '',
                  child: Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom + Sizes.postFormAttachmentNameHeight,
                    right: Sizes.zero,
                    left: Sizes.zero,
                    child: Card(
                      color: TotoColors.primary,
                      child: Padding(
                        padding: EdgeInsets.all(Sizes.accessButtonPaddingVertical),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                filename,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
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
                  )),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                right: Sizes.zero,
                left: Sizes.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(color: TotoColors.primary),
                            bottom: BorderSide(color: Colors.white)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                Sizes.postFormIconMediaPadding,
                                Sizes.postFormIconMediaPadding,
                                Sizes.postFormIconMediaPadding,
                                Sizes.zero),
                            child: InkWell(
                              child: const Icon(
                                Icons.camera_alt,
                                color: TotoColors.primary,
                              ),
                              onTap: () => searchImage(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                Sizes.postFormIconMediaPadding,
                                Sizes.postFormIconMediaPadding,
                                Sizes.postFormIconMediaPadding,
                                Sizes.zero),
                            child: InkWell(
                              child: const Icon(
                                Icons.video_camera_back,
                                color: TotoColors.primary,
                              ),
                              onTap: () => searchVideo(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                Sizes.postFormIconMediaPadding,
                                Sizes.postFormIconMediaPadding,
                                Sizes.postFormIconMediaPadding,
                                Sizes.zero),
                            child: InkWell(
                              child: const Icon(
                                Icons.gif_box,
                                color: TotoColors.primary,
                              ),
                              onTap: () => searchGif(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildFormHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: const Icon(Icons.close),
          onTap: () => Navigator.pop(context),
        ),
        Text('/${widget.board.abbreviation}/ ${widget.board.name}',
            style: TotoTextStyles.titleSmall(context)),
        InkWell(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.postButtonBorderRadius)),
            color: TotoColors.primary,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: Sizes.postButtonTextPaddingVertical, horizontal: Sizes.postButtonTextPaddingHorizontal),
              child: Text(
                Strings.post,
                style: TotoTextStyles.labelLarge(context),
              ),
            ),
          ),
          onTap: () {
            if (contentController.text.isNotEmpty) {
              Api.createPost(widget.board.collectionName, titleController.text,
                  Globals.username, contentController.text, file);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BoardPage(board: widget.board),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Text(Strings.emptyContent),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  /// Search for an Image in the File Explorer
  searchImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null) {
      File newFile = File(result.files.single.path!);
      file = newFile;
      setState(() {
        filename = file.path.split('/').last;
      });
    }
  }

  /// Search for a Video in the File Explorer
  searchVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['mp4']);

    if (result != null) {
      File newFile = File(result.files.single.path!);
      file = newFile;
      setState(() {
        filename = file.path.split('/').last;
      });
    }
  }

  /// Search for a Gif in the File Explorer
  searchGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['gif']);

    if (result != null) {
      File newFile = File(result.files.single.path!);
      file = newFile;
      setState(() {
        filename = file.path.split('/').last;
      });
    }
  }
}
