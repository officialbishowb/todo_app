import 'package:flutter/material.dart';
import 'package:todo_app/model/task_brain.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  static const String _appTitle = "ToDo App";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 255, 131),
        centerTitle: true,
        title: const Text(_appTitle,
            style: TextStyle(color: Color.fromARGB(244, 0, 0, 0))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: const [
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your task",
                labelText: "Task",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
