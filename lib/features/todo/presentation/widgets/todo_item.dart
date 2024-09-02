import 'package:flutter/material.dart';

class ToDoItem extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: false,
            onChanged: (bool? value) {
              // Handle checkbox change
            },
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(date),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Handle edit
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Handle delete
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}