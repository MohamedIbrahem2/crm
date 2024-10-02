class ToDo {
  final int id;
  final int userId;
  final String task;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int completed;

  ToDo({
    required this.id,
    required this.userId,
    required this.task,
    required this.createdAt,
    required this.updatedAt,
    required this.completed,
  });
  ToDo copyWith({
    int? id,
    int? userId,
    String? task,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? completed,
  }) {
    return ToDo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      task: task ?? this.task,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completed: completed ?? this.completed,
    );
  }

  // Factory method to create ToDo object from API response
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      userId: json['user_id'],
      task: json['task'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      completed: json['is_completed'],
    );
  }

  // Method to convert ToDo object into a JSON map (useful for creating/updating tasks)
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'task': task,
    };
  }
}
