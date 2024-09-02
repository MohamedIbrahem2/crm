import 'package:flutter/material.dart';

import '../tickets/action_button_widget.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ActionButtonWidget(icon: Icons.visibility, label: 'Mark as Unread', color: Colors.blue),
          SizedBox(width: 8),
          ActionButtonWidget(icon: Icons.check_circle, label: 'Mark To Done', color: Colors.green),
          SizedBox(width: 8),
          ActionButtonWidget(icon: Icons.star_border, label: 'Mark as Follow Up', color: Colors.orange),
        ],
      ),
    );
  }
}