import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Uncomment when Supabase is configured:
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase - uncomment when you have credentials:
  // await Supabase.initialize(
  //   url: const String.fromEnvironment('SUPABASE_URL'),
  //   anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  // );

  runApp(
    const ProviderScope(
      child: FamilyTreeApp(),
    ),
  );
}
