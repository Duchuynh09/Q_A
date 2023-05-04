class Answer {
  final int id;
  final String content;
  Answer({required this.id,required this.content});
  static Answer fromJson(Map<String, dynamic> json){
    return Answer(id: json['id'], content: json['content']);
  }
}