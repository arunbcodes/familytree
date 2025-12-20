import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
}

/// Provider for the app router
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.tree, // Start at tree for demo; change to splash/login for auth
    debugLogDiagnostics: true,
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

/// Simple splash screen placeholder
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
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
