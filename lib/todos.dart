import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/pages/file_picker.dart';
import 'package:todo_app/styles.dart';
import 'package:todo_app/todo.dart';

class TodosHome extends StatefulWidget {
  TodosHome({Key? key}) : super(key: key);

  @override
  _TodosHomeState createState() => _TodosHomeState();
}

class _TodosHomeState extends State<TodosHome> {
  final _searchController = TextEditingController();
  List<bool> isSelected = List.filled(3, false);
  int taskDone = 0, taskPending = 0;
  List<TodoModel> todos = [];

  @override
  initState() {
    isSelected[0] = true;
    super.initState();
    _getTodos();
    _searchController.addListener(handleTodoSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void handleTodoSearch() {
    final String term = _searchController.text.toLowerCase();
    if (term == '') {
      getTodos();
    }
    todos =
        todos.where((todo) => todo.title.toLowerCase().contains(term)).toList();
    isSelected[0] = true;
    isSelected[1] = isSelected[2] = false;
    setState(() {});
  }

  void handleSelection(int index) async {
    _searchController.text = '';
    await _getTodos();

    isSelected[0] = isSelected[1] = isSelected[2] = false;
    if (index == 1) {
      todos = todos.where((todo) => !todo.isDone).toList();
    } else if (index == 2) {
      todos = todos.where((todo) => todo.isDone).toList();
    }
    setState(() {
      isSelected[index] = true;
    });
  }

  void getTodos() {
    _getTodos();
  }

  void deleteTodo(String id) {
    _deleteTodo(id);
  }

  void updateTodoStatus(String id) {
    _updateTodoStatus(id);
  }

  void updateTodo(TodoModel todo) {
    _updateTodo(todo);
  }

  void _refreshState() {
    _searchController.text = '';
    setState(() {
      _getTodos();
    });
  }

  Future _getTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? prefString = prefs.getString('todos');
    if (prefString != null) {
      final List<TodoModel> todos = TodoModel.decode(prefString);
      setState(() {
        taskDone = todos.fold(0, (res, todo) => todo.isDone ? res + 1 : res);
        taskPending = todos.length - taskDone;
        this.todos = todos;
        _calculateTasks();
      });
    }
  }

  void _calculateTasks() {
    setState(() {
      taskDone = todos.fold(0, (res, todo) => todo.isDone ? res + 1 : res);
      taskPending = todos.length - taskDone;
    });
  }

  void _updateTodo(TodoModel updatedTodo) async {
    final String id = updatedTodo.id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? prefString = prefs.getString('todos');
    List<TodoModel> todos = [];
    if (prefString != null) {
      todos = TodoModel.decode(prefString);
    }
    TodoModel todo = todos.firstWhere((currentTodo) => currentTodo.id == id);
    todo.title = updatedTodo.title;
    todo.desc = updatedTodo.desc;
    // todos = todos.where((currentTodo) => currentTodo.id != todo.id).toList();
    // todos.add(todo);
    String encoded = TodoModel.encode(todos);
    await prefs.setString('todos', encoded);
    setState(() {
      this.todos = todos;
    });
  }

  void _updateTodoStatus(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? prefString = prefs.getString('todos');
    List<TodoModel> todos = [];
    if (prefString != null) {
      todos = TodoModel.decode(prefString);
    }
    TodoModel todo = todos.firstWhere((todo) => todo.id == id);
    todo.isDone = !todo.isDone;
    String encoded = TodoModel.encode(todos);
    await prefs.setString('todos', encoded);
    setState(() {
      this.todos = todos;
      _calculateTasks();
    });
  }

  void _deleteTodo(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? prefString = prefs.getString('todos');
    List<TodoModel> todos = [];
    if (prefString != null) {
      todos = TodoModel.decode(prefString);
    }
    List<TodoModel> filteredTodos =
        todos.where((todo) => todo.id != id).toList();
    String encoded = TodoModel.encode(filteredTodos);
    await prefs.setString('todos', encoded);
    setState(() {
      _calculateTasks();
      this.todos = filteredTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.file_copy),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilePickerTest(),
                  ),
                ),
              ),
            ],
            title: const Text('Todo App'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      const Flexible(
                        child: Text(
                          "My Todo List",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('$taskPending more to do, $taskDone',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 112, 110, 110))),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextField(
                          controller: _searchController,
                          decoration: searchFieldDecoration,
                        ),
                      ),
                      Flexible(
                        child: ToggleButtons(
                          isSelected: isSelected,
                          selectedBorderColor: Colors.blue,
                          onPressed: (index) => handleSelection(index),
                          children: const [
                            Text("All"),
                            Text("Active"),
                            Text("Done")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) => Todo(
                      deleteTodo: deleteTodo,
                      updateTodoStatus: updateTodoStatus,
                      updateTodo: updateTodo,
                      todo: TodoModel(
                          id: todos[index].id,
                          title: todos[index].title,
                          desc: todos[index].desc,
                          isDone: todos[index].isDone),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text('Add Todo'),
            icon: const Icon(Icons.add),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodo()),
              ).then((value) => _refreshState());
            },
          ),
        ),
      ),
    );
  }
}
