class Chat {
  final String name;
  final String message;
  final String time;
  final String lastMessage;

  Chat(this.name, this.message, this.time, this.lastMessage);

  // Add this method
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      json['name'],
      json['message'],
      json['time'],
      json['last_message'],
    );
  }
}
