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

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _titleText(),
            _difficultySlider(),
            _startButton(),
          ],
        ),
      ),
    );
  }

  Widget _titleText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: const [
        Text(
          'Frivia',
          style: TextStyle(
            fontSize: 48,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'a free trivia game',
          style: TextStyle(
            fontSize: 24,
            color: Colors.yellow,
          ),
        ),
        Text(
          "Select a difficulty level and then press 'Start Game'",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _difficultySlider() {
    return Column(
      children: [
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
          },
        )
      ],
    );
  }

  Widget _startButton() {
    return MaterialButton(
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
    );
  }
}
