/// Supabase configuration
/// 
/// To set up Supabase:
/// 1. Create a project at https://supabase.com
/// 2. Run the SQL migration in supabase/migrations/001_initial_schema.sql
/// 3. Copy your project URL and anon key from Settings > API
/// 4. Create a .env file with SUPABASE_URL and SUPABASE_ANON_KEY
/// 5. Or replace the values below directly (not recommended for production)
class SupabaseConfig {
  SupabaseConfig._();

  /// Supabase project URL
  /// Replace with your actual Supabase URL or load from environment
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://your-project.supabase.co',
  );

  /// Supabase anonymous key
  /// Replace with your actual Supabase anon key or load from environment
  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'your-anon-key',
  );

  /// Whether Supabase is configured (not using default values)
  static bool get isConfigured =>
      url != 'https://your-project.supabase.co' && 
      anonKey != 'your-anon-key';

  /// Deep link scheme for OAuth redirects
  static const String deepLinkScheme = 'io.familytree.app';

  /// OAuth redirect URL for mobile
  static String get redirectUrl => '$deepLinkScheme://login-callback/';
}

