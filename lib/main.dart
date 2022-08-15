import 'package:flutter/material.dart';
import 'package:todo_app/todos.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodosHome();
  }
}
