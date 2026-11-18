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

    // Verify Rozio splash screen renders cleanly
    expect(find.text('Rozio'), findsWidgets);
  });
}
