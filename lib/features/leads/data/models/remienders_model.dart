class ReminderModel {
  final int id;
  final String description;
  final String date;
  final String remindTo;
  final String isNotified;

  ReminderModel({
    required this.id,
    required this.description,
    required this.date,
    required this.remindTo,
    required this.isNotified,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'],
      description: json['description'],
      date: json['date'],
      remindTo: json['remind_to'],
      isNotified: json['is_notified'],
    );
  }
}
