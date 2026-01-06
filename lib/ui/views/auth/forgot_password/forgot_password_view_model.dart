import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/router.dart';
import 'package:gericare_doctor/ui/views/auth/verify_otp/verify_otp_view_model.dart';

class ForgotPasswordViewModel extends VGTSBaseViewModel {
  final formKey = GlobalKey<FormState>();
  final emailOrMobileController = TextEditingController();

  String? validateEmailOrMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email or Mobile number is required';
    }
    return null;
  }

  void onGetOtp() {
    if (formKey.currentState?.validate() != true) return;

    // API call later
    navigationService.pushNamed(
      Routes.verifyOtp,
      arguments: OtpFlow.forgotPassword,
    );
  }
}
