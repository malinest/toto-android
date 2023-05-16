import 'package:flutter/material.dart';
import 'package:toto_android/colors.dart';
import 'package:toto_android/textstyles.dart';

class PostFormPage extends StatefulWidget {
  const PostFormPage({Key? key}) : super(key: key);

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
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
                    const TextField(
                      maxLength: 100,
                      decoration: InputDecoration(hintText: 'Post title'),
                    ),
                    Expanded(
                      child: const TextField(
                        maxLines: null,
                        maxLength: 2400,
                        decoration: InputDecoration(
                          hintText: 'Post content',
                        ),
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
                            child: Icon(
                              Icons.camera_alt,
                              color: TotoColors.primary,
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
        Card(
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
      ],
    );
  }
}
