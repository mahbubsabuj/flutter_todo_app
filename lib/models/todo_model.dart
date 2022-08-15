import 'dart:convert';

class TodoModel {
  final String id;
  String title;
  String desc;
  bool isDone;
  TodoModel(
      {required this.id,
      required this.title,
      required this.desc,
      required this.isDone});
  factory TodoModel.fromJson(Map<String, dynamic> jsonData) {
    return TodoModel(
        id: jsonData['id'],
        title: jsonData['title'],
        desc: jsonData['desc'],
        isDone: jsonData['isDone']);
  }
  static Map<String, dynamic> toMap(TodoModel todo) => {
        'id': todo.id,
        'title': todo.title,
        'desc': todo.desc,
        'isDone': todo.isDone,
      };
  static String encode(List<TodoModel> todos) => json.encode(todos
      .map<Map<String, dynamic>>((todo) => TodoModel.toMap(todo))
      .toList());

  static List<TodoModel> decode(String todos) =>
      (json.decode(todos) as List<dynamic>)
          .map<TodoModel>((todo) => TodoModel.fromJson(todo))
          .toList();
}
