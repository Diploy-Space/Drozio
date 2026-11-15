import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Basic sanity test verifying widget pump and environment
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Drozio'),
          ),
        ),
      ),
    );

    expect(find.text('Drozio'), findsOneWidget);
  });
}
