class ActivityLog {
  final String user;
  final List<Activity> activities;

  ActivityLog({required this.user, required this.activities});

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    var activitiesFromJson = json['activities'] as List;
    List<Activity> activitiesList = activitiesFromJson.map((e) => Activity.fromJson(e)).toList();

    return ActivityLog(
      user: json['user'],
      activities: activitiesList,
    );
  }
}

class Activity {
  final String type;
  final String date;
  final String details;

  Activity({required this.type, required this.date, required this.details});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      type: json['type'],
      date: json['date'],
      details: json['details'],
    );
  }
}
