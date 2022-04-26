import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('I am rich'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[700],
          foregroundColor: Colors.blueGrey[100],
        ),
        backgroundColor: Colors.blueGrey[500],
        body: const Center(
          child: Image(
            image: AssetImage(
              'images/diamond.png',
            ),
          ),
        ),
      ),
    );
  }
}
