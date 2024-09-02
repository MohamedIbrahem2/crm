import 'package:flutter/material.dart';
import 'package:sales_crm/core/helpers/extensions.dart';

import '../../../../../core/routing/app_routes.dart';
import 'action_button_widget.dart';

class TicketItemWidget extends StatelessWidget {
  const TicketItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.ticketsDetailsRoute);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'GG',
                    style: TextStyle(color: Colors.purple[800], fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Go Grow',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  '2 mins ago',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Hi, I need help to process the payment visa...',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ActionButtonWidget(
                    color: Colors.blue,
                    icon: Icons.check_circle_outline,
                    label: 'Mark as Viewed',
                  ),
                  SizedBox(width: 8),
                  ActionButtonWidget(
                    color: Colors.green,
                    icon: Icons.check_circle,
                    label: 'Mark To Done',
                  ),
                  SizedBox(width: 8),
                  ActionButtonWidget(
                    color: Colors.orange,
                    icon: Icons.star_border,
                    label: 'Mark as Follow Up',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}