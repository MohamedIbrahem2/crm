

part of 'chats_cubit.dart';
@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Chat> chats;

  ChatLoaded(this.chats);
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
