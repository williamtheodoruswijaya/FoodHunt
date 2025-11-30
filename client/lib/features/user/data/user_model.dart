class UserModel {
  final int userId;
  final String username;
  final String name;
  final String email;
  final String bio;
  final int points;
  final String role;
  final String? profilePicture;

  UserModel({
    required this.userId,
    required this.username,
    required this.name,
    required this.email,
    required this.bio,
    required this.points,
    required this.role,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      bio: json['bio'] ?? '',
      points: json['points'] ?? 0,
      role: json['role'] ?? 'USER',
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'name': name,
      'email': email,
      'bio': bio,
      'points': points,
      'role': role,
      'profilePicture': profilePicture,
    };
  }
}
