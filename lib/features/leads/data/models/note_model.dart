class Note {
  final String description;
  final String createdAt;

  Note({
    required this.description,
    required this.createdAt,
  });

  // Method to convert JSON into a Note object
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      description: json['content'],
      createdAt: json['created_at'], // Ensure the field names match your API response
    );
  }

  // Method to convert a Note object into JSON for sending data to the API
  Map<String, dynamic> toJson() {
    return {
      'content': description,
      'created_at': createdAt,
    };
  }
}
