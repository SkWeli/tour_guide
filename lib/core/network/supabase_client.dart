import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/env.dart';

class SupabaseInit {
  // Track initialization ourselves (do NOT touch Supabase.instance before init).
  static bool _initialized = false;

  static bool get isAvailable =>
      Env.supabaseUrl.isNotEmpty && Env.supabaseAnonKey.isNotEmpty;

  static bool get isInitialized => _initialized;

  static Future<void> ensureInitialized() async {
    if (_initialized) return;

    // If no env vars, run in "demo mode" (no backend).
    if (!isAvailable) {
      // simply skip initialization
      return;
    }

    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        autoRefreshToken: true,
        //persistSession: true,
      ),
    );
    _initialized = true;
  }
}

// Only call this AFTER ensureInitialized() and ONLY if isInitialized is true.
SupabaseClient get supabase {
  if (!SupabaseInit.isInitialized) {
    throw StateError('Supabase not initialized (running in demo mode).');
  }
  return Supabase.instance.client;
}
