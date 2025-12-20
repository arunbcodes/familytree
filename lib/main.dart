import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/services/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase (only if configured)
  // Set SUPABASE_URL and SUPABASE_ANON_KEY environment variables
  // or update lib/core/config/supabase_config.dart
  await SupabaseService.initialize();

  runApp(
    const ProviderScope(
      child: FamilyTreeApp(),
    ),
  );
}
