import 'package:flutter/material.dart';
import 'package:sales_crm/core/constants/app_colors.dart';

import '../../../drawer/presentation/pages/drawer_page.dart';
import '../widgets/chat/chat_page_body.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}












