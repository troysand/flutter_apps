import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  final String _baseUrl = 'https://opentdb.com/api.php';
  List? questions;
  int _currentQuestionindex = 0;

  BuildContext context;

  GamePageProvider({required this.context}) {
    _dio.options.baseUrl = _baseUrl;
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var response = await _dio.get(
      '',
      queryParameters: {
        'amount': _maxQuestions,
        'type': 'boolean',
        'difficulty': 'easy',
      },
    );
    var data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionindex]['question'];
  }

  void answerQuestion(String answer) {
    bool isCorrect =
        questions![_currentQuestionindex]['correct_answer'] == answer;
    print('Correct answer: ' +
        questions![_currentQuestionindex]['correct_answer']);
    print(isCorrect ? 'Correct' : 'Incorrect');
    _currentQuestionindex++;
    notifyListeners();
  }
}
