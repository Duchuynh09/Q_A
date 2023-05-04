// import 'package:flutter/foundation.dart';
// import 'package:quizzy/data/answser.dart';

class Question {
  final String? userId;
  final String id;
  final String question;
  final List<String> options;
  final int answer;
  final String? feedback;
  final int type;

  Question(
      {this.userId,
      required this.id,
      required this.question,
      required this.options,
      required this.answer,
      required this.type,
      this.feedback});
  static Question fromJson(Map<String, dynamic> json) {
    return Question(
        userId: json['userId'] != null ? json['userId'] : '',
        id: json['_id'],
        question: json['quest'],
        type: json['type'],
        options: [...json['anwsers']],
        answer: json['anwserCorrect'],
        feedback: json['feedback'] != null ? json['feedback'] : '');
  }
}
