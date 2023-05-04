import 'dart:convert';

import 'package:http/http.dart' as http;
import '../data/question.dart';

Future<List<Question>> fetchQuizzy() async {
  final List<Question> quizzys = [];
  try {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/quests/'));
    final quizzyMap = json.decode(response.body);
    if (response.statusCode != 200) {
      return quizzys;
    }
    for (var quizzy in quizzyMap) {
      quizzys.add(Question.fromJson({...quizzy}));
    }

    return quizzys;
  } catch (e) {
    print(e);
    return throw Exception('fail');
  }
}
