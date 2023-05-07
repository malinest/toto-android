import 'package:flutter/material.dart';
import 'package:toto_android/colors.dart';
import 'login.dart';

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
        scaffoldBackgroundColor: TotoColors.secondary,
      ),
      home: const LoginPage(),
    );
  }
}
