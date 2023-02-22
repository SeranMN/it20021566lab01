import 'package:flutter/material.dart';
import 'package:it20021566lab01/to_do_task.dart';

void main() {
  runApp(const MaterialApp(
    home: MyWidget(),
  ));
}

List<ToDoTask> tasks = <ToDoTask>[];
final taskController = TextEditingController();

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<String> T = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do App"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                decoration: const InputDecoration(labelText: "Enter Task"),
                controller: taskController,
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    ToDoTask newTodoTask = ToDoTask(
                        task: taskController.text,
                        id: DateTime.now().microsecondsSinceEpoch.toString());
                    tasks.add(newTodoTask);
                  });
                },
                icon: const Icon(Icons.add)),
          ],
        ),
        const Text(
          "All Tasks",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        for (ToDoTask task in tasks)
          ToDoList(
              toDoTask: task,
              onDeleteItem: _onDelete,
              onToDoChanged: _handleCompleted),
      ]),
    );
  }

  void _handleCompleted(ToDoTask todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void _onDelete(String id) {
    setState(() {
      tasks.removeWhere((element) => element.id == id);
    });
  }
}

class ToDoList extends StatelessWidget {
  final ToDoTask toDoTask;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoList(
      {super.key,
      required this.toDoTask,
      required this.onDeleteItem,
      required this.onToDoChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(toDoTask);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(
          toDoTask.completed ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        title: Text(
          toDoTask.task,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration:
                  toDoTask.completed ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(toDoTask.id);
            },
          ),
        ),
      ),
    );
  }
}
