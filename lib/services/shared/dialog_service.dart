import 'package:flutter/material.dart';

class DialogService {
  final GlobalKey<NavigatorState> dialogNavigationKey =
      GlobalKey<NavigatorState>();

  Future<void> showDialog({
    required String title,
    required String description,
  }) async {
    showGeneralDialog(
      context: dialogNavigationKey.currentContext!,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (_, __, ___) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogNavigationKey.currentContext!),
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }
}
