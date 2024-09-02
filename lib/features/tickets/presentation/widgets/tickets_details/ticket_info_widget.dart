
import 'package:flutter/material.dart';

class TicketInfoWidget extends StatelessWidget {
  const TicketInfoWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('GG', style: TextStyle(color: Colors.purple[800], fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        const Text('Go Grow', style: TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        const Text('2 hours ago', style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}