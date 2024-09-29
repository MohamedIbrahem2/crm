class ReminderAddModel {
  final String description;
  final String date;
  final int remindTo;
  final bool sendEmail;

  ReminderAddModel({
    required this.description,
    required this.date,
    required this.remindTo,
    required this.sendEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'notify_date': date,
      'assigned_to': remindTo,
      'email_notification': sendEmail,
    };
  }
}
