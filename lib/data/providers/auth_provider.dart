import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/supabase_service.dart';

/// Provider for Supabase client
final supabaseClientProvider = Provider<SupabaseClient?>((ref) {
  return SupabaseService.client;
});

/// Provider for current auth state
final authStateProvider = StreamProvider<AuthState?>((ref) {
  final stream = SupabaseService.authStateChanges;
  if (stream == null) {
    // Return a stream that never emits if Supabase is not available
    return Stream.value(null);
  }
  return stream;
});

/// Provider for current user
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (state) => state?.session?.user,
    orElse: () => SupabaseService.currentUser,
  );
});

/// Provider for checking if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

/// Provider for checking if Supabase is available
final isSupabaseAvailableProvider = Provider<bool>((ref) {
  return SupabaseService.isAvailable;
});

/// Provider for user's email
final userEmailProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.email;
});

/// Provider for user's display name
final userDisplayNameProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.userMetadata?['full_name'] as String? ?? user?.email?.split('@').first;
});

/// Notifier for auth operations
class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthNotifier() : super(AsyncValue.data(SupabaseService.currentUser));

  /// Sign up with email and password
  Future<void> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    if (!SupabaseService.isAvailable) {
      state = AsyncValue.error(
        Exception('Supabase is not configured'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    try {
      final response = await SupabaseService.client!.signUpWithEmail(
        email: email,
        password: password,
        fullName: fullName,
      );
      state = AsyncValue.data(response.user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Sign in with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    if (!SupabaseService.isAvailable) {
      state = AsyncValue.error(
        Exception('Supabase is not configured'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    try {
      final response = await SupabaseService.client!.signInWithEmail(
        email: email,
        password: password,
      );
      state = AsyncValue.data(response.user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Sign in with OAuth provider
  Future<void> signInWithOAuth(OAuthProvider provider) async {
    if (!SupabaseService.isAvailable) {
      state = AsyncValue.error(
        Exception('Supabase is not configured'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    try {
      await SupabaseService.client!.signInWithOAuth(provider);
      // User will be updated via auth state stream
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    if (!SupabaseService.isAvailable) return;

    state = const AsyncValue.loading();
    try {
      await SupabaseService.client!.signOutUser();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Send password reset email
  Future<void> sendPasswordReset(String email) async {
    if (!SupabaseService.isAvailable) {
      throw Exception('Supabase is not configured');
    }
    await SupabaseService.client!.sendPasswordReset(email);
  }
}

/// Provider for auth notifier
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier();
});

