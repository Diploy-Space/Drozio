import 'package:flutter/services.dart';

/// Centralized utility for consistent tactile/haptic micro-interactions.
class AppHaptics {
  AppHaptics._();

  /// Subtle click for minor interactions (tabs, chips, checkboxes)
  static void selection() {
    try {
      HapticFeedback.selectionClick();
    } catch (_) {
      // Ignored on unsupported platforms / web
    }
  }

  /// Light impact for standard button presses, card taps
  static void light() {
    try {
      HapticFeedback.lightImpact();
    } catch (_) {
      // Ignored
    }
  }

  /// Medium impact for actions like adding to cart, favoriting
  static void medium() {
    try {
      HapticFeedback.mediumImpact();
    } catch (_) {
      // Ignored
    }
  }

  /// Heavy impact for checkout completion, high-stakes deletions
  static void heavy() {
    try {
      HapticFeedback.heavyImpact();
    } catch (_) {
      // Ignored
    }
  }

  /// Success haptic pattern
  static void success() {
    try {
      HapticFeedback.mediumImpact();
    } catch (_) {
      // Ignored
    }
  }

  /// Error vibration
  static void error() {
    try {
      HapticFeedback.heavyImpact();
    } catch (_) {
      // Ignored
    }
  }
}
