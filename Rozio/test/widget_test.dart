import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rozio/main.dart';
import 'package:rozio/providers/cart_provider.dart';
import 'package:rozio/providers/location_provider.dart';
import 'package:rozio/providers/reel_provider.dart';

void main() {
  testWidgets('Rozio app initial render smoke test', (WidgetTester tester) async {
    // Set a realistic mobile device screen size for the test
    tester.view.physicalSize = const Size(1080, 2220);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocationProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => ReelProvider()),
        ],
        child: const RozioApp(),
      ),
    );

    // Verify language selection screen renders
    expect(find.textContaining('Choose your language'), findsOneWidget);
    expect(find.text('Rozio Global'), findsOneWidget);
    expect(find.text('हिन्दी'), findsOneWidget);
    expect(find.text('বাংলা'), findsOneWidget);
    expect(find.textContaining('Continue in English'), findsOneWidget);

    // Tap continue to go to Pincode screen
    await tester.tap(find.textContaining('Continue in English'));
    await tester.pumpAndSettle();

    // Verify Pincode screen
    expect(find.text('Enter your pincode'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
