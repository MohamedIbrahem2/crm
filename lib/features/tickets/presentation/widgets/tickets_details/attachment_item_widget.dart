
import 'package:flutter/material.dart';

class AttachmentItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String size;

  const AttachmentItemWidget({super.key, required this.icon, required this.label, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              Text(size, style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.download, color: Colors.blue),
        ],
      ),
    );
  }
}