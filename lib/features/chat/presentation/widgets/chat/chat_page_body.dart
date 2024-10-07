import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/chats_cubit.dart';
import 'chat_list_item.dart';

class ChatPageBody extends StatelessWidget {
  const ChatPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the chats when the widget is built
    context.read<ChatCubit>().fetchChats();

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChatLoaded) {
          return ListView.builder(
            itemCount: state.chats.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatListItem(chat: state.chats[index]);
            },
          );
        } else if (state is ChatError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('No chats available'));
      },
    );
  }
}
