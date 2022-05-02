import 'package:flutter/material.dart';
import 'package:frivia/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _difficulty = 'easy';
  int _sliderValue = 1;
  double? _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Frivia',
              style: TextStyle(
                fontSize: 48,
                //color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Difficulty: ' + _difficulty,
              style: const TextStyle(
                fontSize: 24,
                //color: Colors.white,
              ),
            ),
            Slider(
              value: _sliderValue.toDouble(),
              min: 1.0,
              max: 3.0,
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value.round();
                  if (_sliderValue == 2) {
                    _difficulty = 'medium';
                  } else if (_sliderValue == 3) {
                    _difficulty = 'hard';
                  } else {
                    _difficulty = 'easy';
                  }
                });
                // if (v == 2.0) {
                //   _difficulty = 'medium';
                // } else if (v == 3.0) {
                //   _difficulty = 'hard';
                // } else {
                //   _difficulty = 'easy';
                // }
              },
            ),
            MaterialButton(
              minWidth: _deviceWidth! * 0.80,
              height: _deviceHeight! * 0.10,
              child: const Text(
                'Start Game',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  //color: Colors.white,
                ),
              ),
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) {
                      return GamePage(
                        difficulty: _difficulty,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
