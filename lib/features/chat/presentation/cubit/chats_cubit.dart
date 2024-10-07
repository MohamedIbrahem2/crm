import 'package:bloc/bloc.dart';
import 'package:crm/core/networking/api_constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/chats_model.dart';
part 'chats_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<void> fetchChats() async {
    emit(ChatLoading());
    try {
      // Replace with your API URL
      final response = await http.get(Uri.parse('${ApiConstants.apiBaseUrl}/'));

      if (response.statusCode == 200) {
        final List<dynamic> chatJson = json.decode(response.body);
        final List<Chat> chats = chatJson.map((json) => Chat.fromJson(json)).toList();
        emit(ChatLoaded(chats));
      } else {
        emit(ChatError('Failed to load chats'));
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
