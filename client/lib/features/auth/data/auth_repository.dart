import 'auth_service.dart';

class AuthRepository {
  final AuthService _service = AuthService();

  Future<void> register({
    required String username,
    required String name,
    required String email,
    required String password,
  }) async {
    await _service.register(
      username: username,
      name: name,
      email: email,
      password: password,
    );
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    await _service.login(username: username, password: password);
  }
}
