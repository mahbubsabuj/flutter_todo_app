import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({
    Key? key,
    required this.todo,
    required this.updateTodo,
  }) : super(key: key);
  final TodoModel todo;
  final Function updateTodo;

  @override
  _UpdateTodoState createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  _updateTodo() {
    TodoModel todo = TodoModel(
        id: widget.todo.id,
        title: _titleController.text,
        desc: _descController.text,
        isDone: widget.todo.isDone);
    widget.updateTodo(todo);
    Navigator.pop(context);
  }

  @override
  void initState() {
    _titleController.text = widget.todo.title;
    _descController.text = widget.todo.desc;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Todo"),
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
                  ? _updateTodo
                  : null,
              child: Text(
                'Update',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
