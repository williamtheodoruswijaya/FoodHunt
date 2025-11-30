import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config/api_config.dart';
import '../../../core/utils/token_manager.dart';

class AuthService {
  Future<void> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"username": username, "password": password}),
    );

    print("LOGIN STATUS: ${response.statusCode}");
    print("LOGIN BODY: ${response.body}");

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception("Login gagal: ${response.body}");
    }

    final body = jsonDecode(response.body);

    // Ambil token sesuai response
    final token = body["data"]?["accessToken"];

    if (token == null) {
      throw Exception("Token tidak ditemukan dalam response");
    }

    // simpan
    TokenManager.setToken(token);
    print("TOKEN STORED: $token");
  }

  Future<void> register({
    required String username,
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Register gagal: ${response.body}');
    }
  }
}
