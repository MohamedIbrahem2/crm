import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/todo_model.dart';
import '../cubit/todo_cubit.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo) onEdit;
  final String title;
  final String description;
  final String status;
  final double progress;
  final String date;
  final String company;
  final Color color;

  const ToDoItem({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.progress,
    required this.date,
    required this.company,
    required this.color,
    required this.todo,
    required this.onEdit
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: Checkbox(
            value: todo.completed == 0 ? false : true,
            onChanged: (bool? value) {
              BlocProvider.of<ToDoCubit>(context).toggleToDo(todo);
            },
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(date),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => onEdit(todo),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<ToDoCubit>(context).deleteToDo(todo.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}