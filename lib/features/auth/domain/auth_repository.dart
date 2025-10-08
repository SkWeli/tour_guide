abstract class AuthRepository {
  Future<void> signIn(String email, String password);
  Future<void> signUpIfNeeded(String email, String password);
  Future<void> signOut();

  /// Emits true when a user is authenticated.
  Stream<bool> authStateChanges();

  /// Snapshot of current auth state
  bool isAuthenticated();
}
