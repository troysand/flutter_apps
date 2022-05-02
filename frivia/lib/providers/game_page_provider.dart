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

  void endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext c) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            "End Game!",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          content: Text('Score: ' + getScore()),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pop(context);
    Navigator.pop(context);
    _currentQuestionindex = 0;
  }
}
