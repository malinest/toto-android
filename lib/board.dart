import 'package:flutter/material.dart';
import 'package:toto_android/colors.dart';
import 'package:toto_android/drawers.dart';
import 'package:toto_android/textstyles.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TotoDrawers.regularDrawer(context),
      appBar: AppBar(
        leading: Icon(
          Icons.keyboard_backspace,
          color: TotoColors.contrastColor,
        ),
        title:
            Text('Technology', style: TotoTextStyles.displayLarge(context)),
        backgroundColor: TotoColors.primary,
      ),
      body: SafeArea(
        child: Card(
          child: Row(
            children: [
              Title(color: TotoColors.textColor, child: Text('Has Elon Musk gone too far?'))
            ],
          ),
        ),
      ),
    );
  }
}
