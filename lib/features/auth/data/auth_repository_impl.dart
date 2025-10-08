import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/supabase_client.dart';
import '../domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _client = supabase;

  @override
  Future<void> signIn(String email, String password) async {
    final res = await _client.auth.signInWithPassword(email: email, password: password);
    if (res.session == null || res.user == null) {
      throw Exception('Failed to sign in');
    }
  }

  @override
  Future<void> signUpIfNeeded(String email, String password) async {
    final got = await _client.auth.signInWithPassword(email: email, password: password);
    if (got.session != null) return; // already exists

    final signUpRes = await _client.auth.signUp(email: email, password: password);
    if (signUpRes.user == null) {
      throw Exception('Failed to sign up');
    }
  }

  @override
  Future<void> signOut() => _client.auth.signOut();

  @override
  Stream<bool> authStateChanges() {
    // map auth state to bool
    final initial = Stream<bool>.value(_client.auth.currentUser != null);
    final changes = _client.auth.onAuthStateChange.map((event) => event.session != null);
    return initial.asyncExpand((_) => changes);
  }

  @override
  bool isAuthenticated() => _client.auth.currentUser != null;
}
