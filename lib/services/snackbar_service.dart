import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SnackbarType { success, error, info, warning }

class SnackbarService {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  void showSnackbar(
      {required String message,
      SnackbarType snakBarType = SnackbarType.info,
      Duration duration = const Duration(seconds: 2)}) {
    final bgColor = _getBackgroundColor(snakBarType);
    final icon = _getIcon(snakBarType);

    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: bgColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin:
            EdgeInsets.only(left: 16.w, right: 16.w, bottom: 120.h, top: 16.h),
      ),
    );
  }

  /// Get background color based on snackbar type
  Color _getBackgroundColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return const Color(0xFF40AE72); // Green
      case SnackbarType.error:
        return const Color(0xFFB42318); // Red
      case SnackbarType.warning:
        return const Color(0xFFFD6320); // Orange
      case SnackbarType.info:
        return const Color(0xFF305EFF); // Blue
    }
  }

  /// Get icon based on snackbar type
  IconData _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Icons.check_circle;
      case SnackbarType.error:
        return Icons.error;
      case SnackbarType.warning:
        return Icons.warning;
      case SnackbarType.info:
        return Icons.info;
    }
  }

  /// Clear all snackbars
  void clearSnackbars() {
    _scaffoldMessengerKey.currentState?.clearSnackBars();
  }
}
