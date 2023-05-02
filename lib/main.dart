import 'package:flutter/material.dart';

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
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Title(
                color: Colors.black,
                child: Text('Toto', style: TextStyle(fontSize: 50),),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      child: Card(
                        color: Color(0xFF9e9583),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Boards',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '[+] New Board',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Card(
                color: Color(0xfffff3dd),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xFF9e9583),
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: GridView.count(
                  primary: false,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  childAspectRatio: 3,
                  padding: EdgeInsets.all(10),
                  scrollDirection: Axis.vertical,
                  children: [
                    Center(child: Text('Random')),
                    Center(child: Text('Technology')),
                    Center(child: Text('Anime')),
                    Center(child: Text('Paranormal')),
                    Center(child: Text('Weapons')),
                    Center(child: Text('Fitness')),
                    Center(child: Text('Videogames')),
                    Center(child: Text('Diy')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
