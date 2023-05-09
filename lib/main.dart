import 'package:flutter/material.dart';
import 'package:toto_android/board.dart';
import 'package:toto_android/colors.dart';
import 'login.dart';
import 'drawers.dart';
import 'signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toto Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'NotoSans',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const BoardPage(),
    );
  }
}
