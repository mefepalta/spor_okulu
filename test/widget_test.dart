import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spor_okulu/main.dart';
import 'package:spor_okulu/widgets/app_splash_screen.dart';

void main() {
  testWidgets('shows splash screen while Firebase is initializing', (
    tester,
  ) async {
    await tester.pumpWidget(const SporOkuluApp());

    expect(find.byType(AppSplashScreen), findsOneWidget);
  });

  testWidgets('Firebase setup screen shows the initialization error', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: FirebaseSetupScreen(error: 'Firebase test error'),
      ),
    );

    expect(find.textContaining('Firebase test error'), findsOneWidget);
  });
}
