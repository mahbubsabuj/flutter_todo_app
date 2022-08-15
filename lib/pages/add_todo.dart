import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/todo_model.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _addTodo() async {
    TodoModel todo = TodoModel(
        id: DateTime.now().toString(),
        title: _titleController.text,
        desc: _descController.text,
        isDone: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefString = prefs.getString('todos');
    List<TodoModel> todos = [];
    if (prefString != null) {
      todos = TodoModel.decode(prefString);
    }
    todos.add(todo);
    String encoded = TodoModel.encode(todos);
    await prefs.setString('todos', encoded);
    _goBack();
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              onChanged: (text) => setState(() {}),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              controller: _descController,
              onChanged: (text) => setState(() {}),
            ),
            ElevatedButton(
              onPressed: (_titleController.value.text.isNotEmpty &&
                      _descController.value.text.isNotEmpty)
                  ? _addTodo
                  : null,
              child: Text(
                'Add',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
