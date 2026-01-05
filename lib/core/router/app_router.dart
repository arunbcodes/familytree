import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/tree_view/screens/tree_screen.dart';
import '../../features/person_detail/screens/person_detail_screen.dart';
import '../../features/person_detail/screens/edit_person_screen.dart';
import '../../features/settings/screens/settings_screen.dart';

/// Route names for type-safe navigation
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboarding = '/onboarding';
  static const String tree = '/tree';
  static const String personDetail = '/person/:id';
  static const String personEdit = '/person/:id/edit';
  static const String settings = '/settings';

  /// Routes that don't require authentication
  static const List<String> publicRoutes = [
    splash,
    login,
    signup,
  ];

  /// Check if a route is public (doesn't require auth)
  static bool isPublicRoute(String location) {
    return publicRoutes.any((route) => location.startsWith(route));
  }
}

/// Provider for the app router
final appRouterProvider = Provider<GoRouter>((ref) {
  // Watch auth state for redirects
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final isSupabaseAvailable = ref.watch(isSupabaseAvailableProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,

    // Auth redirect logic
    redirect: (context, state) {
      final location = state.uri.toString();
      final isOnPublicRoute = AppRoutes.isPublicRoute(location);
      final isOnAuthRoute = location == AppRoutes.login || location == AppRoutes.signup;

      // If Supabase is not configured, allow demo mode (skip auth)
      if (!isSupabaseAvailable) {
        // In demo mode, redirect splash to tree
        if (location == AppRoutes.splash) {
          return AppRoutes.tree;
        }
        // Allow access to all routes in demo mode
        return null;
      }

      // If not authenticated and trying to access protected route
      if (!isAuthenticated && !isOnPublicRoute) {
        // Redirect to login with return URL
        return '${AppRoutes.login}?redirect=${Uri.encodeComponent(location)}';
      }

      // If authenticated and on auth routes, redirect to tree
      if (isAuthenticated && isOnAuthRoute) {
        // Check for redirect parameter
        final redirect = state.uri.queryParameters['redirect'];
        if (redirect != null) {
          return Uri.decodeComponent(redirect);
        }
        return AppRoutes.tree;
      }

      // If authenticated and on splash, go to tree
      if (isAuthenticated && location == AppRoutes.splash) {
        return AppRoutes.tree;
      }

      // No redirect needed
      return null;
    },

    routes: [
      // Splash/Loading screen
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const _SplashScreen(),
      ),

      // Authentication
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),

      // Onboarding
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Main tree view
      GoRoute(
        path: AppRoutes.tree,
        builder: (context, state) => const TreeScreen(),
      ),

      // Person detail
      GoRoute(
        path: AppRoutes.personDetail,
        builder: (context, state) {
          final personId = state.pathParameters['id']!;
          return PersonDetailScreen(personId: personId);
        },
      ),

      // Person edit
      GoRoute(
        path: AppRoutes.personEdit,
        builder: (context, state) {
          final personId = state.pathParameters['id']!;
          return EditPersonScreen(personId: personId);
        },
      ),

      // Settings
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],

    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.tree),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

/// Simple splash screen that checks auth state
class _SplashScreen extends ConsumerWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check if Supabase is available
    final isSupabaseAvailable = ref.watch(isSupabaseAvailableProvider);

    // If Supabase is not available, show demo mode indicator
    if (!isSupabaseAvailable) {
      // Auto-redirect happens via GoRouter redirect logic
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.family_restroom, size: 64),
              SizedBox(height: 16),
              Text(
                'Family Tree',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Demo Mode',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 24),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.family_restroom, size: 64),
            SizedBox(height: 16),
            Text(
              'Family Tree',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
