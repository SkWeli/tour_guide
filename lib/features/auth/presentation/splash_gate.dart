import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/supabase_client.dart';
import '../../auth/application/provider.dart';
import '../../../router/route_paths.dart';
import 'package:go_router/go_router.dart';

class SplashGate extends ConsumerWidget {
  const SplashGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If no Supabase configured → go straight to Dashboard
    if (!SupabaseInit.isAvailable) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.dashboard);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Normal auth flow (Supabase available)
    final auth = ref.watch(authStateProvider);
    return auth.when(
      data: (isAuthed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(isAuthed ? Routes.dashboard : Routes.login);
        });
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => const Scaffold(body: Center(child: Text('Auth error'))),
    );
  }
}
