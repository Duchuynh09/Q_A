import 'package:flutter/cupertino.dart';

class UserPlay with ChangeNotifier {
  late final String name;
  final int? score;
  UserPlay({
    this.score,
    required this.name,
  });
  UserPlay copyWith({int? score, String? name}) {
    return UserPlay(name: name ?? this.name);
  }
}
