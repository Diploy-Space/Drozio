import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/cart_provider.dart';
import 'providers/location_provider.dart';
import 'providers/reel_provider.dart';
import 'views/onboarding/splash_and_walkthrough_screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ReelProvider()),
      ],
      child: const RozioApp(),
    ),
  );
}

class RozioApp extends StatelessWidget {
  const RozioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rozio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const RozioSplashScreen(),
    );
  }
}
