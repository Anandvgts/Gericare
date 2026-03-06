import 'package:doctor/features/auth/data/auth_repository.dart';
import 'package:doctor/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';

part 'reset_password_controller.g.dart';

@riverpod
class ResetPasswordController extends _$ResetPasswordController {
  /// Controllers live here ✅
  final TextEditingController newPasswordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  /// UI flags (not AsyncValue state)
  bool obscureNew = true;
  bool obscureConfirm = true;

  /// UI errors
  String? newPasswordError;
  String? confirmPasswordError;

  @override
  AsyncValue<void> build(ResetPasswordArguments args) {
    /// Cleanup
    ref.onDispose(() {
      newPasswordCtrl.dispose();
      confirmPasswordCtrl.dispose();
    });

    return const AsyncValue.data(null);
  }

  void toggleNewPassword() {
    obscureNew = !obscureNew;
    ref.notifyListeners();
  }

  void toggleConfirmPassword() {
    obscureConfirm = !obscureConfirm;
    ref.notifyListeners();
  }

  bool _validatePasswords() {
    final newPwd = newPasswordCtrl.text.trim();
    final confirmPwd = confirmPasswordCtrl.text.trim();

    // Clear previous errors
    newPasswordError = null;
    confirmPasswordError = null;

    // Validate new password
    if (newPwd.isEmpty) {
      newPasswordError = "Password is required";
      ref.notifyListeners();
      snackBarService.showSnackbar(
        message: 'Please enter new password',
        snakBarType: SnackbarType.warning,
      );
      return false;
    }

    if (newPwd.length < 8) {
      newPasswordError = "Minimum 8 characters required";
      ref.notifyListeners();
      snackBarService.showSnackbar(
        message: 'Password must be at least 8 characters',
        snakBarType: SnackbarType.warning,
      );
      return false;
    }

    // Validate password strength (at least one letter and one number)
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(newPwd);
    final hasNumber = RegExp(r'\d').hasMatch(newPwd);

    if (!hasLetter || !hasNumber) {
      newPasswordError = "Must contain letters and numbers";
      ref.notifyListeners();
      snackBarService.showSnackbar(
        message: 'Password must contain both letters and numbers',
        snakBarType: SnackbarType.warning,
      );
      return false;
    }

    // Validate confirm password
    if (confirmPwd.isEmpty) {
      confirmPasswordError = "Please confirm your password";
      ref.notifyListeners();
      snackBarService.showSnackbar(
        message: 'Please confirm your password',
        snakBarType: SnackbarType.warning,
      );
      return false;
    }

    // Check if passwords match
    if (newPwd != confirmPwd) {
      confirmPasswordError = "Passwords do not match";
      ref.notifyListeners();
      snackBarService.showSnackbar(
        message: 'Passwords do not match',
        snakBarType: SnackbarType.error,
      );
      return false;
    }

    return true;
  }

  Future<void> resetPassword() async {
    if (!_validatePasswords()) {
      return;
    }

    try {
      state = const AsyncValue.loading();

      final newPwd = newPasswordCtrl.text.trim();
      final confirmPwd = confirmPasswordCtrl.text.trim();

      print('ResetPassword - new & confirm => $newPwd & $confirmPwd');
      print('The exchange key ${args.exchangeKey}');

      await ref.read(authRepositoryProvider.notifier).resetPassword(
            args.exchangeKey,
            newPwd,
            confirmPwd,
          );

      debugPrint('✅ Password reset successfully');

      // STEP 4: Show success message
      snackBarService.showSnackbar(
        message:
            'Password reset successfully! Please login with your new password.',
        snakBarType: SnackbarType.success,
      );

      // Small delay so user sees success message
      await Future.delayed(const Duration(seconds: 1));

      // STEP 5: Navigate to login screen
      navigationService.popAllAndPushNamed(Routes.login);

      debugPrint('✅ Navigated to login screen');
    } catch (e) {
      // Error already handled by ApiBaseService
      debugPrint('❌ Reset password error: $e');
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}
