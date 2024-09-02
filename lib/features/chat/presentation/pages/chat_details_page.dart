import 'package:flutter/material.dart';

import '../../domain/entities/chat_enitiy.dart';
import '../widgets/chat_details/chat_details_page_body.dart';

class ChatDetailsPage extends StatelessWidget {
  final Chat chat;

  const ChatDetailsPage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.name),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const  [
                ChatDetailsPageBody(
                  message: "Hey there!",
                  isMe: false,
                  time: "10:30 AM",
                ),
                ChatDetailsPageBody(
                  message: "Hi! How are you?",
                  isMe: true,
                  time: "10:31 AM",
                ),
                ChatDetailsPageBody(
                  message: "I'm good, thanks for asking. How about you?",
                  isMe: false,
                  time: "10:32 AM",
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 70.0,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions),
                  onPressed: () {},
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}