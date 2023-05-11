import 'package:flutter/material.dart';
import 'signup.dart';

void main() {
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
      home: const SignUpPage(),
    );
  }
}
