import 'package:flutter/material.dart';
import '../../user/data/user_service.dart';
import '../../user/data/user_model.dart';
import '../data/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepo = AuthRepository();
  final UserService _userService = UserService();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  //Alur register => login (buat token) => fetch profile
  Future<void> register({
    required String username,
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authRepo.register(
        username: username,
        name: name,
        email: email,
        password: password,
      );

      await login(username, password);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authRepo.login(username: username, password: password);

      _user = await _userService.getProfile(username: username);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
