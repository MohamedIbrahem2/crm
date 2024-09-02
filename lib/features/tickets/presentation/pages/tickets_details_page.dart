import 'package:flutter/material.dart';

import '../widgets/tickets_details/tickets_details_page_body.dart';


class TicketsDetailsPage extends StatelessWidget {
  const TicketsDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Detail'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const TicketsDetailsPageBody(),
    );
  }
}












