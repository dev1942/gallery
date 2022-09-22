import 'package:flutter/material.dart';

class NavigatorKey {
  static bool navigate = false;

  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  static Future<dynamic>? navigateTo(String _rn) {
    return navState.currentState?.pushNamed(_rn);
  }
}
