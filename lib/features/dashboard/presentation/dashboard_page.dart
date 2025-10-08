import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../router/route_paths.dart';
import '../../auth/application/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/supabase_client.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demoMode = !SupabaseInit.isAvailable;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Jobs"),
        actions: [
          if (!demoMode)
            IconButton(
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout),
              tooltip: 'Sign out',
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (demoMode)
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'Demo mode: Supabase not configured.\n'
                'Add SUPABASE_URL and SUPABASE_ANON_KEY to enable auth & data.',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ListTile(
            title: const Text('Bookings'),
            subtitle: Text(demoMode ? 'Demo list (no backend)' : 'Your upcoming & past'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go(Routes.bookings),
          ),
        ],
      ),
    );
  }
}
