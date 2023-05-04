import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzy/data/question.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quizzy/screen/home/home_screen.dart';
import 'package:quizzy/share/AppBar.dart';

class CheckAnswersScreen extends StatelessWidget {
  final Map<int, dynamic> answers;
  final List<Question> questionsCheck;
  const CheckAnswersScreen(this.answers, this.questionsCheck);

  @override
  Widget build(BuildContext context) {
    final List<Question> questions = questionsCheck;
    return Scaffold(
      appBar: AppBarOveright('Kiểm tra đáp án'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: questions.length + 1,
        itemBuilder: _buildItem,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    //them du lieu de kiem tra
    final List<Question> questions = questionsCheck;

    if (index == questions.length) {
      return ElevatedButton(
        child: Text("Xong"),
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomeScreen()),
              ModalRoute.withName(Navigator.defaultRouteName));
        },
      );
    }
    Question question = questions[index];
    bool correct = question.answer == answers[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              HtmlUnescape().convert(question.question),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            SizedBox(height: 5.0),
            Text(
              HtmlUnescape().convert(answers[index] != null
                  ? "${answers[index]}"
                  : 'Chưa hoàn thành'),
              style: TextStyle(
                  color: correct ? Colors.green : Colors.red,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            correct
                ? Container()
                : Text.rich(
                    TextSpan(children: [
                      TextSpan(text: "Đáp án đúng là: "),
                      TextSpan(
                          text: HtmlUnescape()
                              .convert(question.options[question.answer]),
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ]),
                    style: TextStyle(fontSize: 16.0),
                  )
          ],
        ),
      ),
    );
  }
}
