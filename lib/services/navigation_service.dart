import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Push new screen
  Future<dynamic>? pushNamed(
    String route, {
    Object? arguments,
  }) {
    return navigatorKey.currentState
        ?.pushNamed(route, arguments: arguments);
  }

  /// Replace current screen
  Future<dynamic>? replaceWith(
    String route, {
    Object? arguments,
  }) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(route, arguments: arguments);
  }

  /// Clear stack & push
  Future<dynamic>? popAllAndPushNamed(
    String route, {
    Object? arguments,
  }) {
    return navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(
          route,
          (_) => false,
          arguments: arguments,
        );
  }

  /// Pop current screen
  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  /// Check if can pop
  bool canPop() {
    return navigatorKey.currentState?.canPop() ?? false;
  }
}
