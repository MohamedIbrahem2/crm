class AssignedUser {
  final int id;
  final String name;

  AssignedUser({required this.id, required this.name});

  factory AssignedUser.fromJson(Map<String, dynamic> json) {
    return AssignedUser(
      id: json['id'],
      name: json['name'],
    );
  }
}
