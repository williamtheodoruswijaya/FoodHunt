import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../user/data/user_service.dart';
import '../../user/data/user_model.dart';
import '../data/auth_repository.dart';

// State dari login/register

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({UserModel? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// Notifier untuk login dan register

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepo;
  final UserService _userService;

  AuthNotifier(this._authRepo, this._userService) : super(const AuthState());

  // Register
  Future<void> register({
    required String username,
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepo.register(
        username: username,
        name: name,
        email: email,
        password: password,
      );

      // setelah register selesai, lanjut login
      await login(username, password);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // Login
  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepo.login(username: username, password: password);

      //setelah login selesai langsung fetch profile
      UserModel profile = await _userService.getProfile(username: username);

      state = state.copyWith(user: profile);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

// Providers

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthRepository(), UserService());
});
