import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config/api_config.dart';
import '../../../core/utils/token_manager.dart';
import 'user_model.dart';

class UserService {
  Future<UserModel> getProfile({String? username, String? email}) async {
    final token = TokenManager.token;
    if (token == null) throw Exception('Token belum tersedia.');

    if (username == null && email == null) {
      throw Exception('Harus menyertakan username atau email.');
    }

    //Tentukan URI sesuai parameter
    final queryParams = <String, String>{};
    if (username != null) queryParams['username'] = username;
    if (email != null) queryParams['email'] = email;

    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/users/search',
    ).replace(queryParameters: queryParams);

    print("GET PROFILE DEBUG -------------------------------");
    print("REQUEST URL: $uri");
    print("TOKEN: $token");
    print("Query username: $username");
    print("Query email: $email");

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    // 🔥 RESPONSE DEBUG – letakkan DI SINI
    print("STATUS: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");
    print("--------------------------------------------------");
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // ambil objek user dari "data"
      final userJson = decoded["data"];

      return UserModel.fromJson(Map<String, dynamic>.from(userJson));
    } else if (response.statusCode == 404) {
      throw Exception('User tidak ditemukan.');
    } else {
      throw Exception('Gagal ambil profil: ${response.body}');
    }
  }

  Future<UserModel> getProfileById(int userId) async {
    final token = TokenManager.token;
    if (token == null) throw Exception('Token belum tersedia.');

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/users/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final userJson = decoded["data"];
      return UserModel.fromJson(Map<String, dynamic>.from(userJson));
    } else if (response.statusCode == 400) {
      throw Exception('User dengan ID $userId tidak ditemukan.');
    } else {
      throw Exception('Gagal ambil profil user: ${response.body}');
    }
  }
}
