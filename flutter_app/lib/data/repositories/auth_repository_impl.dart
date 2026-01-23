import '../../domain/entities/user_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalStorageService _localStorageService;
  static const String _userKey = 'user_id';

  AuthRepositoryImpl(this._localStorageService);

  @override
  Future<UserSession> login(String userId, String password) async {
    // Mock check: any non-empty ID/password succeeds
    if (userId.isEmpty || password.isEmpty) {
      throw Exception('Invalid credentials');
    }

    await _localStorageService.saveString(_userKey, userId);

    return UserSession(
      userId: userId,
      isAuthenticated: true,
      loginTime: DateTime.now(),
    );
  }

  @override
  Future<void> logout() async {
    await _localStorageService.remove(_userKey);
  }

  @override
  Future<UserSession?> getSession() async {
    final userId = _localStorageService.getString(_userKey);
    if (userId != null && userId.isNotEmpty) {
      return UserSession(
        userId: userId,
        isAuthenticated: true,
        loginTime:
            DateTime.now(), // In a real app, this would be retrieved or refreshed
      );
    }
    return null;
  }
}
