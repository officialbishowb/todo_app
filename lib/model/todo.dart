import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String _key = "todo_list";

class ToDo {
  String? id;
  String? taskName;
  bool isDone;

  ToDo({
    required this.id,
    required this.taskName,
    this.isDone = false,
  });

  static Future<List<ToDo>> toDoList() async {
    List<ToDo> toDoList = [];
    List<String> toDoListItems = await getToDoList();

    if (toDoListItems.isNotEmpty) {
      for (String toDoItems in toDoListItems) {
        Map<String, dynamic> toDoItem = json.decode(toDoItems);
        toDoList.add(ToDo(
            id: toDoItem['id'],
            taskName: toDoItem['taskName'],
            isDone: toDoItem['isDone']));
      }
    }
    return toDoList;
  }

  static Future<List<String>> getToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? todos = prefs.getStringList(_key);
    return todos ?? [];
  }

  static Future<void> addToDoList(String todo, bool isDone) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> todos = await getToDoList();
    Map<String, dynamic> newToDo = {
      "id": generateId(),
      "taskName": todo,
      "isDone": isDone
    };
    todos.add(json.encode(newToDo));
    prefs.setStringList(_key, todos);
  }

  static Future<void> deleteToDoList(String todoID) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> todos = await getToDoList();
    for (int i = 0; i < todos.length; i++) {
      Map<String, dynamic> todoMap = json.decode(todos[i]);
      if (todoMap["id"] == todoID) {
        todos.removeAt(i);
        break;
      }
    }
    prefs.setStringList(_key, todos);
  }

  static Future<void> changeDoneStatus(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> todos = await getToDoList();

    for (int i = 0; i < todos.length; i++) {
      Map<String, dynamic> todoMap = json.decode(todos[i]);
      if (todoMap["id"] == id) {
        todoMap["isDone"] = !todoMap["isDone"];
        todos[i] = json.encode(todoMap);
        break;
      }
    }
    prefs.setStringList(_key, todos);
  }

  static String generateId() {
    List<String> numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
    numbers.shuffle();
    String id = '';
    for (int i = 0; i < 8; i++) {
      id += numbers[i];
    }
    return id;
  }
}
