import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toto_android/model/globals.dart';
import 'package:toto_android/views/mainview.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if((prefs.getBool('loggedIn') ?? false) && (prefs.getString('username')?? '').isNotEmpty){
    Globals.isLogged = true;
    Globals.username = prefs.getString('username')!;
  }
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
      home: const MainPage(),
    );
  }
}
