class AuthRequest {
  final String username;
  final String password;

  AuthRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}
