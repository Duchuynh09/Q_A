import 'package:flutter/cupertino.dart';
import 'package:quizzy/auth/auth.dart';

class UserManager with ChangeNotifier {
  late UserPlay userPlay;

  void changeName(String name) {
    userPlay = UserPlay(name: name);
  }
}
