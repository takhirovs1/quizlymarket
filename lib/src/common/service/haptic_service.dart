import 'dart:developer';

import 'package:flutter/services.dart' show HapticFeedback;

/// Helper enum for [HapticsService]
enum HapticFeedbackType { light, medium, heavy, selectionClick, vibrate }

/// {@template haptics_service}
/// Service for haptic feedback.
/// {@endtemplate}
final class HapticsService {
  factory HapticsService() => _instance;
  HapticsService._internal();
  static final HapticsService _instance = HapticsService._internal();

  bool _isEnabled = true;

  static bool get isEnabled => _instance._isEnabled;
  static set isEnabled(bool value) {
    if (_instance._isEnabled != value) _instance._isEnabled = value;
  }

  static void toggle() => isEnabled = !isEnabled;

  static void lightImpact() => trigger(HapticFeedbackType.light);

  static void mediumImpact() => trigger(HapticFeedbackType.medium);

  static void heavyImpact() => trigger(HapticFeedbackType.heavy);

  static void selectionClick() => trigger(HapticFeedbackType.selectionClick);

  static void vibrate() => trigger(HapticFeedbackType.vibrate);

  static void trigger(HapticFeedbackType type) {
    if (!_instance._isEnabled) {
      _hapticsAreDisabledLog();
      return;
    }

    return switch (type) {
      HapticFeedbackType.light => HapticFeedback.lightImpact().ignore(),
      HapticFeedbackType.medium => HapticFeedback.mediumImpact().ignore(),
      HapticFeedbackType.heavy => HapticFeedback.heavyImpact().ignore(),
      HapticFeedbackType.selectionClick => HapticFeedback.selectionClick().ignore(),
      HapticFeedbackType.vibrate => HapticFeedback.vibrate().ignore(),
    };
  }

  static void _hapticsAreDisabledLog() =>
      log(name: 'HapticsService', 'Haptics are disabled so not triggering vibration');
}
