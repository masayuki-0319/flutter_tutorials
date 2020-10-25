import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemBuilder: (_, index) {
            final key = GlobalKey<ScaffoldState>();

            return ListTile(
              onTap: () {
                key.currentState.showSnackBar(
                  SnackBar(
                    content: Text('$index bookmarked'),
                  ),
                );
              },
              title: Container(
                margin: const EdgeInsets.all(16),
                height: 100,
                child: Scaffold(
                  key: key,
                  backgroundColor: Colors.black12,
                  body: Center(
                    child: Text(
                      index.toString(),
                      style: GoogleFonts.sawarabiMincho(
                        fontSize: 60,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
