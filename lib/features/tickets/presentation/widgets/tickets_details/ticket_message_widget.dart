import 'package:flutter/material.dart';

class TicketMessageWidget extends StatelessWidget {
  const TicketMessageWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hi,'),
        SizedBox(height: 8),
        Text('I need help to process the payment via my VISA card.'),
        SizedBox(height: 8),
        Text('Its returning failed payment after the checkout. I need to send out this campaign within today, can you please help ASAP.'),
        SizedBox(height: 8),
        Text('Thanks'),
      ],
    );
  }
}