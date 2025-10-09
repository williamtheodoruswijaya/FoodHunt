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
      '${ApiConfig.baseUrl}users/search',
    ).replace(queryParameters: queryParams);

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(Map<String, dynamic>.from(data));
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
      Uri.parse('${ApiConfig.baseUrl}users/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(Map<String, dynamic>.from(data));
    } else if (response.statusCode == 400) {
      throw Exception('User dengan ID $userId tidak ditemukan.');
    } else {
      throw Exception('Gagal ambil profil user: ${response.body}');
    }
  }
}
