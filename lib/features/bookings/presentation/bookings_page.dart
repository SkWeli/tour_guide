import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/bookings_list_controller.dart';
import '../../../router/route_paths.dart';
import 'package:go_router/go_router.dart';
import '../../../core/network/supabase_client.dart';

class BookingsPage extends ConsumerWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demoMode = !SupabaseInit.isAvailable;

    if (demoMode) {
      // Simple demo list
      final demo = List.generate(5, (i) => 'Demo booking #${i + 1}');
      return Scaffold(
        appBar: AppBar(title: const Text('Bookings')),
        body: ListView.separated(
          itemCount: demo.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (_, i) => ListTile(
            title: Text(demo[i]),
            subtitle: const Text('No backend connected'),
            onTap: () => context.go(Routes.bookingDetail('demo-$i')),
          ),
        ),
      );
    }

    // Real data path (Supabase available)
    final bookings = ref.watch(bookingsListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      body: bookings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$e'),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => ref.read(bookingsListProvider.notifier).load(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('No bookings yet.'));
          }
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, i) {
              final b = list[i];
              final time = b.startTime?.toLocal().toString().replaceFirst(':00.000', '') ?? 'TBD';
              return ListTile(
                title: Text('Booking ${b.id.substring(0, 6)} • ${b.status}'),
                subtitle: Text('${b.meetingPointAddress ?? 'No address'}\n$time'),
                isThreeLine: true,
                onTap: () => context.go(Routes.bookingDetail(b.id)),
              );
            },
          );
        },
      ),
    );
  }
}
