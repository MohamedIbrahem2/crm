import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/tickets_details/tickets_details_page_body.dart';


class TicketsDetailsPage extends StatelessWidget {
  const TicketsDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
          backgroundColor: AppColors.primaryYellow,
          title: const Text('Ticket detail'),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.upload_file),
          //     onPressed: () {
          //       context.pushNamed(AppRoutes.leadsImportRoute);
          //     },
          //   ),
          // ],
        ),
      ),
      body: const TicketsDetailsPageBody(),
    );
  }
}












