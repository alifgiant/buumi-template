abstract class AuthService {
  final String userId;

  const AuthService(this.userId);

  bool get isLoggedIn => userId.isNotEmpty;

  Future<AuthResult> login(String email, String password);
  Future<void> logout();
}

enum AuthResult {
  success,
  invalid,
  error,
}
