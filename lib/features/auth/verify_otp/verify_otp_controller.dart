import 'dart:async';
import 'package:doctor/features/auth/data/auth_repository.dart';
import 'package:doctor/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verify_otp_controller.g.dart';

@riverpod
class VerifyOtpController extends _$VerifyOtpController {

  late final List<TextEditingController> controllers;

  Timer? _timer;
  int seconds = 60;

  @override
  AsyncValue<void> build(VerifyOtpArguments args) {
   
    controllers = List.generate(6, (_) => TextEditingController());

    _startTimer();
    ref.onDispose(() {
      _timer?.cancel();
      for (final c in controllers) {
        c.dispose();
      }
    });

    return const AsyncValue.data(null);
  }

  String get otp => controllers.map((c) => c.text).join();

  void _startTimer() {
    _timer?.cancel();
    seconds = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds == 0) {
        _timer?.cancel();
      } else {
        seconds--;
        ref.notifyListeners(); // rebuild UI
      }
    });
  }

  void onOtpChanged({
    required BuildContext context,
    required int index,
  }) {
    final text = controllers[index].text;

    if (text.isNotEmpty && index < 5) {
      FocusScope.of(context).nextFocus();
    }

    if (text.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }

    if (otp.length == 6) {
      FocusScope.of(context).unfocus();

      Future.delayed(const Duration(milliseconds: 300), () {
        if (otp.length == 6) {
          verifyOtp();
        }
      });
    }
  }

  bool _validateOtp() {
    if (otp.isEmpty) {
      snackBarService.showSnackbar(
        message: 'Please enter OTP',
        snakBarType: SnackbarType.warning,
      );
      return false;
    }

    if (otp.length != 6) {
      snackBarService.showSnackbar(
        message: 'Please enter complete 6-digit OTP',
        snakBarType: SnackbarType.warning,
      );
      return false;
    }

    

    return true;
  }

  Future<void> verifyOtp() async {
    if (!_validateOtp()) {
      return;
    }
    state = const AsyncValue.loading();

    try {
      print('verify OTP : $otp');
      print('exchangeKey ${args.exchangeKey}');

      final response = await ref
          .read(authRepositoryProvider.notifier)
          .verifyOtp(args.exchangeKey, otp);

      print('OTP verified successfully');

      // Get new exchange_key from response (if provided)
      final newExchangeKey =
          response['exchange_key'] as String? ?? args.exchangeKey;

      snackBarService.showSnackbar(
        message: 'OTP verified successfully!',
        snakBarType: SnackbarType.success,
      );

      await Future.delayed(const Duration(milliseconds: 500));

      navigationService.pushNamed(
        Routes.resetPassword,
        arguments: ResetPasswordArguments(
          exchangeKey: newExchangeKey,
          identifier: args.identifier,
        ),
      );

      debugPrint('✅ Navigated to reset password screen');
    } catch (e) {
      print(' Verify OTP error: $e');
      for (final controller in controllers) {
        controller.clear();
      }
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  void resendOtp() async {
    if (seconds > 0) {
      snackBarService.showSnackbar(
        message: 'Please wait $seconds seconds before resending',
        snakBarType: SnackbarType.info,
      );
      return;
    }
    state = const AsyncValue.loading();

    try {
      print('Resending OTP to: ${args.identifier}');

      final response = await ref
          .read(authRepositoryProvider.notifier)
          .forgotPassword(args.identifier);

      print('✅ New exchange key: ${response.exchangeKey}');

      snackBarService.showSnackbar(
        message: 'OTP resent successfully',
        snakBarType: SnackbarType.success,
      );

      for (final controller in controllers) {
        controller.clear();
      }

      _startTimer();

      print('OTP resent successfully');
    } catch (e) {
      print('Resend OTP error: $e');
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  void clearOtp() {
    for (final controller in controllers) {
      controller.clear();
    }
  }
}
