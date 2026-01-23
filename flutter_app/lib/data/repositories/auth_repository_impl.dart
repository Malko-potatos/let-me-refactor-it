import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/auth_repository.dart';

/// Implementation of AuthRepository using SharedPreferences
class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferences prefs;

  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _tokenKey = 'authToken';

  AuthRepositoryImpl(this.prefs);

  @override
  Future<bool> login(String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Simple validation - in a real app, this would authenticate with a server
      if (email.isNotEmpty && password.isNotEmpty) {
        // Generate a fake token
        final token = 'token_${DateTime.now().millisecondsSinceEpoch}';
        await prefs.setBool(_isLoggedInKey, true);
        await prefs.setString(_tokenKey, token);
        return true;
      }

      return false;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_tokenKey);
  }

  @override
  Future<bool> isAuthenticated() async {
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString(_tokenKey);
  }
}
