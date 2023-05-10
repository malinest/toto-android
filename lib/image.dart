import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  final String url;

  const ImagePage({Key? key, required this.url}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool isImageTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  child: Icon(
                    Icons.keyboard_backspace_sharp,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
