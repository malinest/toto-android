import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        fontFamily: 'NotoSans'
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
         mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Title(
              color: Colors.black,
              child: Text(
                'Boards',
                style: TextStyle(fontSize: 50),
                textAlign: TextAlign.left,
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
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SecondRoute()));
                                },
                                child: Text(
                                  '[+] New Board',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
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
                    borderRadius: BorderRadius.circular(5)),
                child: GridView.count(
                  primary: false,
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

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Board")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text("Create Board"),
        ),
      ),
    );
  }
}
