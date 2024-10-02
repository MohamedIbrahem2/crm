import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/todo_model.dart';
import '../cubit/todo_cubit.dart';

class TodoAddDialog extends StatefulWidget {
  final ToDo? todo;
  final Function(String) onSubmit;

  const TodoAddDialog({super.key, this.todo, required this.onSubmit});

  @override
  _TodoAddDialogState createState() => _TodoAddDialogState();
}

class _TodoAddDialogState extends State<TodoAddDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todo?.task ?? '');  // Pre-fill for edit
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.todo != null ? 'Edit ToDo' : 'Add ToDo'),  // Update title based on mode
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Enter your task'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        widget.todo != null ? TextButton(
          onPressed: () {
            widget.onSubmit(_controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Update'),  // Button text changes
        ) : TextButton(
          onPressed: () {
            final newTodo = ToDo(
              id: 0,
              userId: 2,
              task: _controller.text,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              completed: 0,
            );

            context.read<ToDoCubit>().addToDo(newTodo);
            Navigator.of(context).pop();
          },
          child: const Text('Add'),  // Button text changes
        ),
      ],
    );
  }
}
