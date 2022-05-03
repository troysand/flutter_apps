import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  final String _baseUrl = 'https://opentdb.com/api.php';
  List? questions;
  int _currentQuestionindex = 0;
  int _currentScore = 0;
  String difficulty;

  BuildContext context;

  GamePageProvider({required this.context, this.difficulty = 'easy'}) {
    _dio.options.baseUrl = _baseUrl;
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var response = await _dio.get(
      '',
      queryParameters: {
        'amount': _maxQuestions,
        'type': 'boolean',
        'difficulty': difficulty,
      },
    );
    var data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionindex]['question'];
  }

  ///
  /// Show an alert dialog informing the user whether the answer was correct
  /// of incorrect. Also displays the current score.
  ///
  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![_currentQuestionindex]['correct_answer'] == answer;
    if (isCorrect) _currentScore++;
    _currentQuestionindex++;
    showDialog(
      context: context,
      builder: (BuildContext c) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
          content: Text('Score: ' + getScore()),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.pop(context);
    if (_currentQuestionindex == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  String getScore() {
    return '$_currentScore/$_currentQuestionindex';
  }

  ///
  /// Get a string to display to the user after the game is over.
  /// The string is different depending on the user's final score.
  ///
  String getGameOverText() {
    double percent =
        _currentScore.toDouble() * 100.0 / _currentQuestionindex.toDouble();
    if (percent >= 90.0) {
      return 'Great Job!';
    } else if (percent >= 75.0) {
      return 'Nice score!';
    } else if (percent >= 50.0) {
      return 'Not bad!';
    }
    return 'Try better next time.';
  }

  ///
  /// This function is called when the game is over to display a popup
  /// showing the players final score. The popup will disappear after
  /// a few seconds.
  ///
  void endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext c) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Center(
            child: Text(
              "Game Over!",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Score: ' + getScore(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                getGameOverText(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );

    // wait a few seconds then navigate back to the home page by popping
    // the end game alert dialgog, and then popping the game page.
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
