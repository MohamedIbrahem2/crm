import 'package:flutter/material.dart';
import 'package:sales_crm/features/tickets/presentation/widgets/tickets/ticket_Item_widget.dart';


class OpenTicketsExpansionWidget extends StatelessWidget {
  const OpenTicketsExpansionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const ExpansionTile(
      title: Text(
        'My Open Tickets (6)',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        TicketItemWidget(),
        TicketItemWidget(),
        TicketItemWidget(),
        TicketItemWidget(),
      ],
    );
  }
}