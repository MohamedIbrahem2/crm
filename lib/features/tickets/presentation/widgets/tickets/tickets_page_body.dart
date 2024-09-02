import 'package:flutter/material.dart';
import 'package:sales_crm/features/tickets/presentation/widgets/tickets/open_tickets_expansion_widget.dart';
import 'package:sales_crm/features/tickets/presentation/widgets/tickets/search_bar_widget.dart';

import '../../pages/tickets_page.dart';

class TicketsPageBody extends StatelessWidget {
  const TicketsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Tickets',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SearchBarWidget(),
            SizedBox(height: 16),
            OpenTicketsExpansionWidget(),
          ],
        ),
      ),
    );
  }
}
