import 'package:crm/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TodoAddDialog extends StatefulWidget {
  const TodoAddDialog({super.key});

  @override
  _TodoAddDialogState createState() => _TodoAddDialogState();
}

class _TodoAddDialogState extends State<TodoAddDialog> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Add Note'),
      content: TextField(
        controller: _noteController,
        decoration: const InputDecoration(hintText: 'Enter your note'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryYellow),
          onPressed: () {
            String note = _noteController.text;
            // Do something with the note, like saving it to a database
            Navigator.of(context).pop();
          },
          child: const Text('Add',style: TextStyle(color: Colors.black),),
        ),
      ],
    );
  }
}
