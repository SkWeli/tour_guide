import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/network/supabase_client.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Will no-op if you haven't provided SUPABASE_URL/ANON_KEY.
  await SupabaseInit.ensureInitialized();
  runApp(const ProviderScope(child: GuideApp()));
}
