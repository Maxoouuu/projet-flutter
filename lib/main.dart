import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskList(),
    );
  }
}

class Task {
  String text;
  bool isCompleted;

  Task(this.text, this.isCompleted);
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [
    Task('Tâche 1', false),
    Task('Tâche 2', false),
    Task('Tâche 3', false),
  ];

  bool isLoading = false;

  Future<String> fetchChuckNorrisJoke() async {
    final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load joke');
    }
  }

  Future<void> _showChuckNorrisJoke(Task task) async {
    setState(() {
      isLoading = true;
    });

    try {
      final jokeResponse = await fetchChuckNorrisJoke();
      final joke = jsonDecode(jokeResponse)['value'] as String; // Extraire la blague du JSON

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tâche terminée ! Voici une blague de Chuck Norris !'),
            content: Text(joke),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

      setState(() {
        isLoading = false;
        task.isCompleted = true;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Impossible de récupérer une blague de Chuck Norris.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  Future<void> _editTask(Task task) async {
    final editedTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTaskPage(task: task)),
    );

    if (editedTask != null) {
      setState(() {
        task.text = editedTask;
      });
    }
  }

  Future<void> _addTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskPage()),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(Task(newTask, false));
      });
    }
  }

  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de tâches'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      _toggleTaskCompletion(task); // Appel de la fonction pour changer l'état de complétion de la tâche.
                      if (value == true) {
                        _showChuckNorrisJoke(task);
                      }
                    },
                  ),
                  title: Text(
                    task.text,
                    style: TextStyle(
                      decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTask(task);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16), // Ajout d'un espace entre la liste et le bouton
          ElevatedButton(
            onPressed: _addTask,
            child: Text('Ajouter une tâche'),
          ),
          if (isLoading) CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class EditTaskPage extends StatefulWidget {
  final Task task;

  EditTaskPage({required this.task});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.task.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la tâche'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _taskController,
            onChanged: (value) {
              // Met à jour l’état lorsque le texte change.
            },
            decoration: InputDecoration(
              hintText: 'Entrez la nouvelle tâche',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _taskController.text); // Retourne le texte de la tâche modifiée.
            },
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }
}

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une tâche'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _taskController,
            onChanged: (value) {
              // Met à jour l’état lorsque le texte change.
            },
            decoration: InputDecoration(
              hintText: 'Entrez une nouvelle tâche',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _taskController.text); // Retourne le nouveau texte de la tâche.
            },
            child: Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}
