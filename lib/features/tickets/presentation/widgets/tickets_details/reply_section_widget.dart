import 'package:flutter/material.dart';

class ReplySectionWidget extends StatelessWidget {
  const ReplySectionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reply to:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const  Row(
            children: [
              Text('Go Grow (info@gogrow.com)'),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            hintText: 'Type your reply here...',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: Text('Send'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: Size(double.infinity, 48),
          ),
        ),
      ],
    );
  }
}