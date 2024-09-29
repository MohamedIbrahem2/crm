import 'package:flutter/material.dart';
import 'package:crm/core/constants/app_colors.dart';

import '../../../drawer/presentation/pages/drawer_page.dart';
import '../widgets/chat/chat_page_body.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  DateTime? _lastPressedAt;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
        appBar: AppBar(
          backgroundColor: AppColors.primaryYellow,
          title: const Text('chat'),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        body: ChatPageBody(),
      ),
    );
  }
}












