import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final onToDoChanged;
  final onDeleteItem;

  final ToDo todo;
  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          onTap: () {
            onToDoChanged(todo, todo.id);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          tileColor: const Color.fromARGB(255, 241, 241, 241),
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.blue,
          ),
          title: Text(
            todo.taskName!,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: todo.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              iconSize: 18,
              onPressed: () {
                onDeleteItem(todo.id);
              },
            ),
          ),
        ));
  }
}
