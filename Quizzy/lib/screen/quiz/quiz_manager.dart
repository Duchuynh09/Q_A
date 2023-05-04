import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
import 'package:quizzy/data/question.dart';
import 'package:quizzy/service/MonggoAPI.dart';

class QuestionController with ChangeNotifier {
  List<Question> _questions = [];
  List<Question> get question {
    return [..._questions];
  }

  int get length {
    return _questions.length;
  }

  Future<void> fetchQuizzys() async {
    _questions = await fetchQuizzy();
    notifyListeners();
  }
}
