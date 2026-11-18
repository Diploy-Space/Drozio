import 'package:flutter/material.dart';

/// Application-wide constants, design tokens, and configuration values.
class AppConstants {
  AppConstants._();

  // Branding & Metadata
  static const String appName = 'Rozio';
  static const String appTagline = 'Next-Gen Shoppable Video & Hyperlocal Marketplace';
  static const String appVersion = '1.0.0+1';
  static const String repositoryUrl = 'https://github.com/Diploy-Space/Drozio.git';
  static const String supportEmail = 'support@rozio.shop';
  static const String supportPhone = '+91 1800 200 4567';

  // SLAs & Deliveries
  static const String expressDeliveryTime = '30 Minutes';
  static const String defaultCity = 'Andheri West, Mumbai';
  static const String defaultPincode = '400053';
  static const String defaultState = 'Maharashtra';
  static const String currencySymbol = '₹';
  static const String fallbackCurrencySymbol = '\$';

  // Spacing Tokens
  static const double spacingXXS = 2.0;
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radii
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusPill = 999.0;

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationMedium = Duration(milliseconds: 500);
  static const Duration durationSlow = Duration(milliseconds: 800);

  // Responsive Breakpoints
  static const double maxMobileContentWidth = 430.0;
  static const double tabletBreakpoint = 600.0;
  static const double desktopBreakpoint = 1024.0;

  // Standard EdgeInsets
  static const EdgeInsets paddingScreen = EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  static const EdgeInsets paddingScreenHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets paddingCard = EdgeInsets.all(16.0);
}
