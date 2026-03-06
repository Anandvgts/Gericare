import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class NetworkService {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isOnline = true;

  /// Get current online status
  bool get isOnline => _isOnline;

  /// Initialize network monitoring
  void init() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _handleConnectivityChange(results);
    });

    debugPrint('✅ NetworkService initialized');
  }

  /// Handle connectivity changes
  void _handleConnectivityChange(List<ConnectivityResult> results) {
    final wasOnline = _isOnline;
    _isOnline = results.isNotEmpty && results.last != ConnectivityResult.none;

    if (_isOnline && !wasOnline) {
      debugPrint('📶 Network connection restored');
      Fluttertoast.showToast(msg: 'Back online');
    } else if (!_isOnline && wasOnline) {
      debugPrint('📵 Network connection lost');
      Fluttertoast.showToast(msg: 'No internet connection');
    }
  }

  /// Check current internet connection
  Future<bool> checkConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      _isOnline = connectivityResult.isNotEmpty &&
          connectivityResult.last != ConnectivityResult.none;

      if (!_isOnline) {
        debugPrint('❌ No internet connection');
        Fluttertoast.showToast(msg: 'Please turn on your internet');
      }

      return _isOnline;
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      return false;
    }
  }

  /// Dispose network monitoring
  void dispose() {
    _subscription?.cancel();
    debugPrint('NetworkService disposed');
  }
}
