import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/auth_repository.dart';
import 'provider.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this._read) : super(const AsyncData(null));
  final Ref _read;

  AuthRepository get _repo => _read.read(authRepositoryProvider);

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.signUpIfNeeded(email, password); // ensure user exists (dev convenience)
      await _repo.signIn(email, password);
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.signOut();
    });
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) => AuthController(ref));
