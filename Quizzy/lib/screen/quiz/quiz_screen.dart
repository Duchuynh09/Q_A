import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:quizzy/auth/authManager.dart';
import 'package:quizzy/constants.dart';
import 'package:quizzy/data/question.dart';
import '../../share/AppBar.dart';
import '../../themes/app_text_styles.dart';
import '../result/result_screen.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quizScreen';
  late List<Question> quest;
  QuizScreen(List<Question> matchQuest, {Key? key}) {
    super.key;
    this.quest = matchQuest;
  }

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late List<Question> question;
  // late Future<void> _fetchQuizzy;
  late int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  late AnimationController _animationController;
  late Animation _animation;
  @override
  void initState() {
    question = widget.quest;
    // _fetchQuizzy = context.read<QuestionController>().fetchQuizzys();
    _animationController =
        AnimationController(duration: Duration(seconds: 30), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward().whenComplete(nextQuestion);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void nextQuestion() {
    if (_currentIndex < (question.length - 1)) {
      // Reset the counter
      _animationController.reset();
      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return QuizResultScreen(answers: _answers, localQuizz: question);
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarOveright('Tính giờ làm'),
        body: question == []
            ? Center(
                child: Text('Chưa có dữ liệu'),
              )
            : oldQuizScreen(question[_currentIndex])

        // body: FutureBuilder(
        //   future: _fetchQuizzy,
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       final question = quest[_currentIndex];
        //       return Stack(
        //         children: [
        //           // SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
        //           SafeArea(child: oldQuizScreen(question))
        //         ],
        //       );
        //     }
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
        );
  }

  Widget progressBar() {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          // LayoutBuilder provide us the available space for the conatiner
          // constraints.maxWidth needed for our animation
          LayoutBuilder(
            builder: (context, constraints) => Container(
              // from 0 to 1 it takes 60s
              width: constraints.maxWidth * _animation.value,
              decoration: BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${(_animation.value * 60).round()} sec"),
                  SvgPicture.asset("assets/icons/clock.svg"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget oldQuizScreen(Question question) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: progressBar(),
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text("${_currentIndex + 1}"),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  question.question,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              )
            ],
          ),
          SizedBox(height: 20.0),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...question.options.map(
                  (option) => RadioListTile(
                    title: Text(option),
                    value: option,
                    groupValue: _answers[_currentIndex],
                    onChanged: (value) {
                      setState(() {
                        _answers[_currentIndex] = option;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                onPressed: nextQuestion,
                label: Text('Next'),
                icon: Icon(Icons.arrow_forward),
              ),
            ),
          )
        ],
      ),
    );
  }
}
