// This is a basic Flutter widget test.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:familytree/app.dart';

void main() {
  testWidgets('App renders without error', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: FamilyTreeApp(),
      ),
    );

    // Verify that the app renders (basic smoke test)
    expect(find.byType(FamilyTreeApp), findsOneWidget);
  });
}
