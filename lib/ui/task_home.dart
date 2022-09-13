import 'package:flutter/material.dart';
import 'package:todo_app/ui/todo_item.dart';

import '../model/todo.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  static const String _appTitle = "ToDo App";
  static List<ToDo> todoList = ToDo.toDoList(); // Fix coming soon

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          TaskScreen._appTitle,
        ),
      ),
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.only(top: 20.0, left: 15.0, right: 10.0),
          child: Column(
            children: [
              Expanded(
                  child: ListView(children: [
                for (ToDo toDoList in TaskScreen.todoList)
                  ToDoItem(
                    todo: toDoList,
                    onToDoChanged: _handelToDoChange,
                    onDeleteItem: _deleteItem,
                  ),
              ])),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  margin: const EdgeInsets.only(bottom: 30, left: 10, right: 5),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 233, 233),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 161, 161, 161),
                            offset: Offset(0.0, 0.0),
                            blurRadius: 2.0),
                      ],
                      borderRadius: BorderRadius.circular(3.0)),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: "Enter your task",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 5.0),
                    ),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(bottom: 30, right: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ElevatedButton(
                    onPressed: () {
                      _addItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50)),
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 38,
                      ),
                    ),
                  ),
                )
              ],
            ))
      ]),
    );
  }

  void _handelToDoChange(ToDo todo, String taskId) {
    setState(() {
      todo.isDone = !todo.isDone;
      ToDo.changeDoneStatus(taskId);
    });
  }

  void _addItem(String newTask) {
    setState(() {
      if (newTask.isNotEmpty) {
        ToDo.addToDoList(newTask, false);
      }
    });
    _todoController.clear();
  }

  void _deleteItem(String taskId) {
    setState(() {
      ToDo.deleteToDoList(taskId);
    });
  }
}
