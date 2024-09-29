
import 'package:flutter/material.dart';
import 'package:crm/features/tickets/presentation/widgets/tickets_details/reply_section_widget.dart';
import 'package:crm/features/tickets/presentation/widgets/tickets_details/ticket_info_widget.dart';
import 'package:crm/features/tickets/presentation/widgets/tickets_details/ticket_message_widget.dart';

import 'action_widget.dart';
import 'attachments_widget.dart';

class TicketsDetailsPageBody extends StatelessWidget {
  const TicketsDetailsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help Needed For Payment Failure',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ActionWidget(),
            SizedBox(height: 16),
            TicketInfoWidget(),
            SizedBox(height: 16),
            TicketMessageWidget(),
            SizedBox(height: 16),
            AttachmentsWidget(),
            SizedBox(height: 16),
            ReplySectionWidget(),
          ],
        ),
      ),
    );
  }
}
