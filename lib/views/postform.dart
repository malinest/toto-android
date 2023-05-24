import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:toto_android/model/colors.dart';
import 'package:toto_android/model/globals.dart';
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
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Expanded(
                child: Column(
                  children: [
                    buildFormHeader(context),
                    TextField(
                      maxLength: 100,
                      decoration: InputDecoration(hintText: 'Post title'),
                      controller: titleController,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 500),
                      child: TextField(
                        maxLines: null,
                        maxLength: 2400,
                        decoration: InputDecoration(
                          hintText: 'Post content',
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
                    bottom: MediaQuery.of(context).viewInsets.bottom + 40,
                    right: 0,
                    left: 0,
                    child: Card(
                      color: TotoColors.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                filename,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            InkWell(
                                child: Icon(
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
                right: 0,
                left: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(color: TotoColors.primary),
                            bottom: BorderSide(color: Colors.white)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: InkWell(
                              child: Icon(
                                Icons.camera_alt,
                                color: TotoColors.primary,
                              ),
                              onTap: () => SearchImage(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: InkWell(
                              child: Icon(
                                Icons.video_camera_back,
                                color: TotoColors.primary,
                              ),
                              onTap: () => SearchVideo(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: InkWell(
                              child: Icon(
                                Icons.gif_box,
                                color: TotoColors.primary,
                              ),
                              onTap: () => SearchGif(),
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
          child: Icon(Icons.close),
          onTap: () => Navigator.pop(context),
        ),
        Text('/${widget.board.abbreviation}/ ${widget.board.name}',
            style: TotoTextStyles.titleSmall(context)),
        InkWell(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: TotoColors.primary,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
              child: Text(
                'Post',
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
                    child: Text("The content can't be empty"),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  SearchImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null) {
      File newfile = File(result.files.single.path!);
      file = newfile;
      setState(() {
        filename = file.path.split('/').last;
        print(filename);
      });
    } else {
      // User canceled the picker
    }
  }

  SearchVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['mp4']);

    if (result != null) {
      File newfile = File(result.files.single.path!);
      file = newfile;
      setState(() {
        filename = file.path.split('/').last;
        print(filename);
      });
    } else {
      // User canceled the picker
    }
  }

  SearchGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['gif']);

    if (result != null) {
      File newfile = File(result.files.single.path!);
      file = newfile;
      setState(() {
        filename = file.path.split('/').last;
        print(filename);
      });
    } else {
      // User canceled the picker
    }
  }
}
