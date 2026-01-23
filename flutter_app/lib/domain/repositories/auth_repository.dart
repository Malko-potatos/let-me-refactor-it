/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Logs in with email and password
  Future<bool> login(String email, String password);

  /// Logs out the current user
  Future<void> logout();

  /// Checks if user is authenticated
  Future<bool> isAuthenticated();

  /// Gets the current authentication token
  Future<String?> getToken();
}
