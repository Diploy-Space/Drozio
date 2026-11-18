import 'package:flutter/material.dart';
import '../../views/catalog/figma_screen_catalog.dart';
import '../../views/home/home_screen.dart';
import '../../views/main_navigation_screen.dart';
import '../../views/onboarding/splash_and_walkthrough_screens.dart';
import '../../views/reels/reels_screen.dart';
import '../../views/cart/cart_screen.dart';
import '../../views/orders/orders_screen.dart';
import '../../views/search/search_screen.dart';

/// Centralized named route definitions for Rozio.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String walkthrough = '/walkthrough';
  static const String catalog = '/catalog';
  static const String mainNav = '/main';
  static const String home = '/home';
  static const String search = '/search';
  static const String reels = '/reels';
  static const String cart = '/cart';
  static const String orders = '/orders';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const RozioSplashScreen());
      case walkthrough:
        return MaterialPageRoute(builder: (_) => const RozioOnboardingWalkthroughScreen());
      case catalog:
        return MaterialPageRoute(builder: (_) => const FigmaScreenCatalogScreen());
      case mainNav:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case reels:
        return MaterialPageRoute(builder: (_) => const ReelsScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case orders:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
