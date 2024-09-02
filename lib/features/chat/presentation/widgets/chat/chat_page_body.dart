import 'package:flutter/material.dart';

import '../../../domain/entities/chat_enitiy.dart';
import 'chat_list_item.dart';

class ChatPageBody extends StatelessWidget {
  ChatPageBody({super.key});


  final List<Chat> chats = [
    Chat('John Doe', 'Hello, how are you?', '10:30 AM'),
    Chat('Jane Smith', 'Are we meeting today?', 'Yesterday'),
    Chat('Bob Johnson', 'The project is done!', '23/3/24'),
    Chat('Alice Brown', 'Can you send me the files?', '22/3/24'),
    Chat('Charlie Davis', 'Let\'s catch up soon!', '21/3/24'),
    Chat('Eve White', 'I\'m good, thanks!', '20/3/24'),
    Chat('Frank Black', 'I\'m on my way', '19/3/24'),
    Chat('Grace Green', 'I\'m almost there', '18/3/24'),
    Chat('Henry Blue', 'How are you doing?', '17/3/24'),
    Chat('Ivy Grey', 'I\'m fine, thank you', '16/3/24'),
    Chat('Jack Red', 'I\'m on my way', '15/3/24'),
    Chat('Kelly Orange', 'I\'m almost there', '14/3/24'),
    Chat('Liam Pink', 'How are you doing?', '13/3/24'),
    Chat('Mia Purple', 'I\'m fine, thank you', '12/3/24'),
    Chat('Noah Brown', 'I\'m on my way', '11/3/24'),
    Chat('Olivia White', 'I\'m almost there', '10/3/24'),
    Chat('Peter Black', 'How are you doing?', '9/3/24'),
    Chat('Quinn Green', 'I\'m fine, thank you', '8/3/24'),
    Chat('Ryan Blue', 'I\'m on my way', '7/3/24'),
    Chat('Sara Grey', 'I\'m almost there', '6/3/24'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ChatListItem(chat: chats[index]);
      },
    );
  }
}