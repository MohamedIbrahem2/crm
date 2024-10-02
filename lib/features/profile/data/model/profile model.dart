class Profile {
  final String name;
  final String email;
  final String photoUrl; // Add a field for the photo URL

  Profile({
    required this.name,
    required this.email,
    required this.photoUrl, // Include photo URL in the constructor
  });

  // Factory constructor to create a Profile from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      photoUrl: json['photo'] ?? "",
    );
  }
}
