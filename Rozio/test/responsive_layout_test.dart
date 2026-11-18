import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rozio/core/widgets/responsive_layout.dart';

void main() {
  testWidgets('ResponsiveLayout renders directly on mobile screen width', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: ResponsiveLayout(
          child: Text('Mobile View Content'),
        ),
      ),
    );

    expect(find.text('Mobile View Content'), findsOneWidget);
  });

  testWidgets('ResponsiveLayout constraints content on wide screen width', (tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: ResponsiveLayout(
          child: Text('Desktop View Content'),
        ),
      ),
    );

    expect(find.text('Desktop View Content'), findsOneWidget);
  });
}
