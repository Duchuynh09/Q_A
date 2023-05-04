import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/data/question.dart';
import 'package:quizzy/screen/check/check_answers_screen.dart';
// import 'package:quizzy/screen/quiz/quiz_screen.dart';

import '../../share/AppBar.dart';
import '../quiz/quiz_manager.dart';

class QuizResultScreen extends StatelessWidget {
  final Map<int, dynamic> answers;
  final List<Question> localQuizz;
  QuizResultScreen({required this.answers, required this.localQuizz});

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    final List<Question> questions = localQuizz;
    this.answers.forEach((index, value) {
      if (questions[index].options[questions[index].answer] == value) correct++;
    });

    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);

    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBarOveright('Điểm số'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Số câu hỏi", style: titleStyle),
                  trailing: Text("${questions.length}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Điểm", style: titleStyle),
                  trailing: Text(
                      "${(correct / questions.length * 100).toStringAsFixed(1)}%",
                      style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Đáp án đúng", style: titleStyle),
                  trailing: Text("$correct/${questions.length}",
                      style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Đáp án sai", style: titleStyle),
                  trailing: Text(
                      "${questions.length - correct}/${questions.length}",
                      style: trailingStyle),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    icon: Icon(Icons.home),
                    label: Text('Trả về trang chủ'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.check_circle_rounded),
                    label: Text('Xem câu trả lời'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              CheckAnswersScreen(answers, questions)));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
