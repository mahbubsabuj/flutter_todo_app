import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/pages/update_todo.dart';

class Todo extends StatelessWidget {
  const Todo({
    Key? key,
    required this.todo,
    required this.updateTodo,
    required this.deleteTodo,
    required this.updateTodoStatus,
  }) : super(key: key);
  final TodoModel todo;
  final Function updateTodo;
  final Function deleteTodo;
  final Function updateTodoStatus;

  void _deleteTodo() {
    deleteTodo(todo.id);
  }

  void _updateTodoStatus() {
    updateTodoStatus(todo.id);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Card(
        color: todo.isDone ? Colors.grey : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: todo.isDone,
                      onChanged: (bool? value) => _updateTodoStatus(),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        todo.title,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(todo.title),
                        content: Text(todo.desc),
                        actions: <Widget>[
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary:
                                    Theme.of(context).colorScheme.onPrimary,
                                primary: Theme.of(context).colorScheme.primary,
                              ).copyWith(
                                  elevation: ButtonStyleButton.allOrNull(0.0)),
                              onPressed: () => {Navigator.pop(context)},
                              child: const Text('OK'),
                            ),
                          )
                        ],
                      ),
                    ),
                  },
                  icon: const Icon(Icons.info, color: Colors.teal),
                ),
                IconButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateTodo(
                                  todo: todo,
                                  updateTodo: updateTodo,
                                )))
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                          'Are you sure you want to delete this todo ?'),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Theme.of(context).colorScheme.onPrimary,
                            primary: Theme.of(context).colorScheme.primary,
                          ).copyWith(
                              elevation: ButtonStyleButton.allOrNull(0.0)),
                          onPressed: () => {Navigator.pop(context)},
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Theme.of(context).colorScheme.onPrimary,
                            primary: Theme.of(context).colorScheme.error,
                          ).copyWith(
                              elevation: ButtonStyleButton.allOrNull(0.0)),
                          onPressed: () => {
                            Navigator.pop(context),
                            _deleteTodo(),
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(Icons.delete, color: Colors.red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
