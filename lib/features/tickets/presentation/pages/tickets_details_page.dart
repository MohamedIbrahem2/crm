import 'package:flutter/material.dart';
import 'package:sales_crm/features/tickets/presentation/widgets/tickets/action_button_widget.dart';

import '../widgets/tickets_details/tickets_details_page_body.dart';


class TicketsDetailsPage extends StatelessWidget {
  const TicketsDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Detail'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const TicketsDetailsPageBody(),
    );
  }
}












