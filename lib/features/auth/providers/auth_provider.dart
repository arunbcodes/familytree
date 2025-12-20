import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user.dart';

/// Authentication state
sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final AppUser user;
  const AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

/// Auth notifier for managing authentication state
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthInitial()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    state = const AuthLoading();

    // TODO: Check Supabase auth status
    // For now, simulate a demo user
    await Future.delayed(const Duration(milliseconds: 500));

    // Uncomment when Supabase is configured:
    // final session = Supabase.instance.client.auth.currentSession;
    // if (session != null) {
    //   final user = _mapSupabaseUser(session.user);
    //   state = AuthAuthenticated(user);
    // } else {
    //   state = const AuthUnauthenticated();
    // }

    // Demo mode: auto-authenticate with demo user
    state = AuthAuthenticated(_createDemoUser());
  }

  AppUser _createDemoUser() {
    return AppUser(
      id: 'demo-user-id',
      email: 'demo@familytree.app',
      displayName: 'Demo User',
      emailVerified: true,
      createdAt: DateTime.now(),
      lastSignInAt: DateTime.now(),
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AuthLoading();

    try {
      // TODO: Implement Supabase sign in
      // await Supabase.instance.client.auth.signInWithPassword(
      //   email: email,
      //   password: password,
      // );

      await Future.delayed(const Duration(seconds: 1));
      state = AuthAuthenticated(_createDemoUser());
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AuthLoading();

    try {
      // TODO: Implement Supabase sign up
      // await Supabase.instance.client.auth.signUp(
      //   email: email,
      //   password: password,
      //   data: {'display_name': displayName},
      // );

      await Future.delayed(const Duration(seconds: 1));
      state = AuthAuthenticated(_createDemoUser());
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> signOut() async {
    state = const AuthLoading();

    try {
      // TODO: Implement Supabase sign out
      // await Supabase.instance.client.auth.signOut();

      await Future.delayed(const Duration(milliseconds: 500));
      state = const AuthUnauthenticated();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    // TODO: Implement Supabase password reset
    // await Supabase.instance.client.auth.resetPasswordForEmail(email);
  }

  void clearError() {
    if (state is AuthError) {
      state = const AuthUnauthenticated();
    }
  }
}

/// Provider for auth notifier
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

/// Provider for current user (convenience)
final currentUserProvider = Provider<AppUser?>((ref) {
  final authState = ref.watch(authProvider);
  if (authState is AuthAuthenticated) {
    return authState.user;
  }
  return null;
});

/// Provider for checking if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState is AuthAuthenticated;
});

