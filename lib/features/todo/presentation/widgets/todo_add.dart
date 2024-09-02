import 'package:flutter/material.dart';

class TodoAddDialog extends StatefulWidget {
  @override
  _TodoAddDialogState createState() => _TodoAddDialogState();
}

class _TodoAddDialogState extends State<TodoAddDialog> {
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Note'),
      content: TextField(
        controller: _noteController,
        decoration: InputDecoration(hintText: 'Enter your note'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(


          onPressed: () {
            String note = _noteController.text;
            // Do something with the note, like saving it to a database
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
