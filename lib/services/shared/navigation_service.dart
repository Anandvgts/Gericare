import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String route, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(route, arguments: arguments);
  }

  Future<dynamic> replaceWith(String route, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(route, arguments: arguments);
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }

  void popAllAndPushNamed(String route) {
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(route, (route) => false);
  }
}
