

import 'package:flutter/material.dart';
import 'package:crm/core/constants/app_colors.dart';
import 'package:crm/features/drawer/presentation/pages/drawer_page.dart';

import '../widgets/tickets/tickets_page_body.dart';


class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        // Check if the back button was pressed within the last 2 seconds
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2)) {
          _lastPressedAt = DateTime.now();
          // Show the Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit the app'),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Prevent the back navigation
        }
        return true; // Allow the back navigation (close the app)
      },
      child: Scaffold(
        drawer: const DrawerPage(),
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            backgroundColor: AppColors.primaryYellow,
            title: const Text('Tickets'),
          ),
        ),
        body: const TicketsPageBody(),
      ),
    );
  }
}







