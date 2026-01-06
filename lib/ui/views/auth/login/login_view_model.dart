import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/locator.dart';
import 'package:gericare_doctor/router.dart';
import 'package:gericare_doctor/services/api/api_model/error_response_exception.dart';
import 'package:gericare_doctor/services/api/auth_service.dart';
import 'package:gericare_doctor/services/shared/preferences_service.dart';
import 'package:gericare_doctor/ui/views/auth/verify_otp/verify_otp_view_model.dart';

class LoginViewModel extends VGTSBaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final PreferenceService _pref = locator<PreferenceService>();

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /* =============================== LOGIN =============================== */

  Future<void> onLogin() async {
    if (formKey.currentState?.validate() != true) return;

    setBusy(true);

    try {
      final response = await _authService.login(
        identifier: usernameController.text.trim(),
        password: passwordController.text,
      );

      /// ✅ SUCCESS TOAST
      Fluttertoast.showToast(
        msg: "Login successful",
        toastLength: Toast.LENGTH_SHORT,
      );

      // SAVE TOKEN
      print(response.token);
      print(response.user.toJson());

      await _pref.saveBearerToken(response.token);
      await _pref.saveUser(response.user.toJson());

      // NAVIGATE
      navigationService.pushNamed(
        Routes.dashboard,
        arguments: OtpFlow.login,
      );
    } on ErrorResponseException catch (e) {
      /// ✅ API ERROR (INVALID CREDENTIALS)
      final message = e.error ?? "Invalid username or password";

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
      );
    } catch (e) {
      /// ✅ FALLBACK ERROR
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try again.",
      );
    } finally {
      setBusy(false);
    }
  }

  void onForgotPassword() {
    navigationService.pushNamed(Routes.forgotPassword);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
