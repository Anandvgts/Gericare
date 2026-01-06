import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/router.dart';


enum OtpFlow {
  login,
  forgotPassword,
}


class VerifyOtpViewModel extends VGTSBaseViewModel {
  final OtpFlow flow;

  VerifyOtpViewModel({required this.flow});

  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  int _seconds = 60;
  int get seconds => _seconds;

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    _seconds = 60;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
      } else {
        _seconds--;
        notifyListeners();
      }
    });
  }

  bool get canResend => _seconds == 0;

  String get otp =>
      controllers.map((c) => c.text).join();

  void onVerifyOtp() {
    if (otp.length != 4) {
      // You can show snackbar/toast later
      return;
    }

    if (flow == OtpFlow.login) {
      navigationService.replaceWith(Routes.dashboard);
    } else {
      navigationService.replaceWith(Routes.resetPassword);
    }
  }

  void onResendOtp() {
    if (!canResend) return;
    startTimer();
    // API call later
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }
}
