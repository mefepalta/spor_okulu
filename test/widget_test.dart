import 'package:flutter_test/flutter_test.dart';
import 'package:spor_okulu/main.dart';

void main() {
  testWidgets('shows Firebase setup screen when initialization fails', (
    tester,
  ) async {
    await tester.pumpWidget(
      const SporOkuluApp(firebaseSetupError: 'Firebase test error'),
    );

    expect(find.byType(FirebaseSetupScreen), findsOneWidget);
    expect(find.textContaining('Firebase test error'), findsOneWidget);
  });
}
