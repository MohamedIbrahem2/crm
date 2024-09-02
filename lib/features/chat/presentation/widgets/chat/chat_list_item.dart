import 'package:flutter/material.dart';

import '../../../domain/entities/chat_enitiy.dart';
import '../../pages/chat_details_page.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;

  const ChatListItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Text(chat.name[0], style: const TextStyle(color: Colors.white)),
      ),
      title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
      Text(chat.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(chat.time, style: const TextStyle(color: Colors.grey)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatDetailsPage(chat: chat)),
        );
      },
    );
  }
}