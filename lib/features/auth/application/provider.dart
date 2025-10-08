import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/auth_repository.dart';
import '../data/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepositoryImpl());

/// Emits true when authed, false otherwise; keeps latest snapshot.
final authStateProvider = StreamProvider<bool>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges();
});

/// Synchronous read of current auth state
final isAuthedProvider = Provider<bool>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.isAuthenticated();
});
