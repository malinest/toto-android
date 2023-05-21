import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:toto_android/api/api.dart';
import 'package:toto_android/colors.dart';
import 'package:toto_android/textstyles.dart';

import 'api/board.dart';
import 'globals.dart';

class PostFormPage extends StatefulWidget {
  final Board board;
  const PostFormPage({Key? key, required this.board}) : super(key: key);

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  File file = File('');
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
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        maxLength: 2400,
                        decoration: InputDecoration(
                          hintText: 'Post content',
                        ),
                        controller: contentController,
                      ),
                    )
                  ],
                ),
              ),
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
                              onTap: () => SearchFile(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Icon(
                              Icons.video_camera_back,
                              color: TotoColors.primary,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Icon(
                              Icons.gif_box,
                              color: TotoColors.primary,
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
        Text('/g/ Technology', style: TotoTextStyles.titleSmall(context)),
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
            Api.createPost(widget.board.collectionName, titleController.text, Globals.username, contentController.text, file);
          },
        ),
      ],
    );
  }

  SearchFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File newfile = File(result.files.single.path!);
       file = newfile;
    } else {
      // User canceled the picker
    }
  }
}
