import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizzy/data/question.dart';
import 'package:quizzy/screen/quiz/quiz_screen.dart';

class CategoryHeaderWidget extends StatelessWidget {
  final List<Question> matchQuests;
  final IconData iconCategory;
  final String typeOption;
  const CategoryHeaderWidget({
    required this.matchQuests,
    required this.typeOption,
    required this.iconCategory,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        matchQuests.shuffle();
        final playQuests = matchQuests.take(5).toList();
        Navigator.pushNamed(context, QuizScreen.routeName,
            arguments: playQuests);
      },
      child: Container(
        // padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(iconCategory, color: Colors.white, size: 36),
            const SizedBox(height: 12),
            Text(
              typeOption,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
