

import 'package:flutter/material.dart';

import '../../data/models/todo_model.dart';

class ToDoSummaryHeader extends StatefulWidget {
  final int complete;
  final int inComplete;
  final int all;
  const ToDoSummaryHeader({super.key, required this.all, required this.complete, required this.inComplete});

  @override
  State<ToDoSummaryHeader> createState() => _ToDoSummaryHeaderState();
}

class _ToDoSummaryHeaderState extends State<ToDoSummaryHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSummaryItem(widget.all.toString(), 'All', Colors.blue),
            _buildSummaryItem(widget.inComplete.toString(), 'In Completed', Colors.orange),
            _buildSummaryItem(widget.complete.toString(), 'Completed', Colors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String count, String label, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(count, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}