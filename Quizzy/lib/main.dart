import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/auth/authManager.dart';
import 'package:quizzy/data/question.dart';
import 'package:quizzy/screen/home/home_screen.dart';
import 'package:quizzy/screen/home/welcomeScreen.dart';
import 'package:quizzy/screen/quiz/quiz_manager.dart';
import 'package:quizzy/screen/quiz/quiz_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuestionController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserManager(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizzy',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          // QuizScreen.routeName:(context) =>  QuizScreen(matchQuest)
          '/homeScreen': (context) => const HomeScreen()
        },
        // initialRoute: ,
        onGenerateRoute: (settings) {
          if (settings.name == QuizScreen.routeName) {
            final args = settings.arguments as List<Question>;
            return MaterialPageRoute(
              builder: (context) {
                return QuizScreen(args);
              },
            );
          }
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
        home: welcomeScreen(),
      ),
    );
  }
}
