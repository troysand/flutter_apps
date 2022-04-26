import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I Am Poor',
      home: Scaffold(
        backgroundColor: Colors.deepPurple[600],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          foregroundColor: Colors.deepPurple[200],
          title: const Text('I Am Poor'),
          centerTitle: true,
        ),
        body: const Center(
          child: Image(
            image: AssetImage('images/bitcoin2.jpg'),
          ),
        ),
      ),
    );
  }
}
