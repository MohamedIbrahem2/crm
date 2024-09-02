

import 'package:flutter/material.dart';
import 'package:sales_crm/core/constants/app_colors.dart';
import 'package:sales_crm/features/drawer/presentation/pages/drawer_page.dart';

import '../widgets/tickets/tickets_page_body.dart';


class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryYellow,
        title: Text('Tickets'),
      ),
      body: const TicketsPageBody(),
    );
  }
}







