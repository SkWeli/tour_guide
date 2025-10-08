import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/supabase_client.dart';

class BookingsRemoteSource {
  final SupabaseClient _client = supabase;

  Future<List<Map<String, dynamic>>> listMineRaw() async {
    // Get current user id
    final uid = _client.auth.currentUser?.id;
    if (uid == null) return [];

    final res = await _client
        .from('bookings')
        .select('*')
        .eq('guide_id', uid)
        .order('start_time', ascending: true);

    return (res as List).cast<Map<String, dynamic>>();
  }
}
