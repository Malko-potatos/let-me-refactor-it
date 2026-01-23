import '../entities/user_session.dart';

abstract class AuthRepository {
  Future<UserSession> login(String userId, String password);
  Future<void> logout();
  Future<UserSession?> getSession();
}
