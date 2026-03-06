import 'package:doctor/features/auth/data/auth_repository.dart';
import 'package:doctor/services/snackbar_service.dart';

import 'package:flutter/material.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  /// Text controllers LIVE HERE ✅
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? passwordError;
  bool obscure = true;


  @override
  AsyncValue<void> build() {
    ref.onDispose(() {
      usernameController.dispose();
      passwordController.dispose();
    });
    return const AsyncValue.data(null); // idle state
  }

   void togglePassword() {
    obscure = !obscure;
    ref.notifyListeners();
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    usernameError = null;
    passwordError = null;

    // Username validation
    if (username.isEmpty) {
      usernameError = "Username is required";
    } else if (!_isValidUsername(username)) {
      usernameError = "Enter a valid email, phone, or username";
    }

    // Password validation
    if (password.isEmpty) {
      passwordError = "Password is required";
    } else if (password.length < 6) {
      passwordError = "Password must be at least 6 characters";
    }

    // If any error → update UI & stop
    if (usernameError != null || passwordError != null) {
      state = const AsyncValue.data(null);
      ref.notifyListeners();
      return;
    }

    // // Validate inputs
    if (username.isEmpty || password.isEmpty) {
      snackBarService.showSnackbar(
        message: "Username and password are required",
        snakBarType: SnackbarType.warning,
      );
      return;
    }

    state = const AsyncValue.loading();

    try {
      // Login via repository
      final response = await ref.read(authRepositoryProvider.notifier).login(
            username,
            password,
          );

      await sessionService.createSession(
      token: response.token!,
      user: response.user!,
    );

     print('Session logged sucess');
    print('User: ${sessionService.currentUser}');
    print('Token: ${sessionService.token}');

      // // Save credentials
      // await preferenceService.setBearerToken(response.token!);
      // await preferenceService.setUserInfo(response.user!);

      // print('Userdetails ${preferenceService.getUserInfo()}');
      // print('Access token ${preferenceService.getBearerToken()}');

     
      snackBarService.showSnackbar(
        message: "Login successful! Welcome back.",
        snakBarType: SnackbarType.success,
        duration: const Duration(seconds: 2),
      );

      print('Login respoisne -${response.toString()}');

      // Navigate to dashboard (with slight delay so user sees success message)
      await Future.delayed(const Duration(milliseconds: 500));
      navigationService.popAllAndPushNamed(Routes.dashboard);
    } catch (e) {
      print('Login failed: $e');
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  bool _isValidUsername(String input) {
    return _isEmail(input) || _isPhone(input) || _isSimpleUsername(input);
  }

  bool _isEmail(String input) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(input);
  }

  bool _isPhone(String input) {
    return RegExp(r'^[0-9]{8,15}$').hasMatch(input);
  }

  bool _isSimpleUsername(String input) {
    return input.length >= 3;
  }
}





