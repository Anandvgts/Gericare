import 'package:doctor/features/auth/data/auth_repository.dart';



import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';

part 'forgot_password_controller.g.dart';

@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  /// Text controller lives here ✅
  final TextEditingController inputController =
      TextEditingController();

  /// Simple UI error (optional, not state file)
  String? inputError;

  @override
  AsyncValue<void> build() {
    /// Cleanup
    ref.onDispose(() {
      inputController.dispose();
    });

    return const AsyncValue.data(null); // idle
  }

  bool _isNumeric(String input) => RegExp(r'^[0-9]+$').hasMatch(input);

bool _isValidPhone(String input) => RegExp(r'^[0-9]{10}$').hasMatch(input);

bool _isValidEmail(String input) =>
    RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(input);


 Future<void> getOtp() async {
  final value = inputController.text.trim();

  inputError = null;
  ref.notifyListeners();

  // Validation (UI level)
  if (value.isEmpty) {
    inputError = "Email or Mobile number is required";
    ref.notifyListeners();
    return;
  }

  late String identifier;
  late String type;

  // Determine input type
  if (_isNumeric(value)) {
    if (!_isValidPhone(value)) {
      inputError = "Enter valid 10 digit mobile number";
      ref.notifyListeners();
      return;
    }
    identifier = value;
    type = "phone";
  } else {
    if (!_isValidEmail(value)) {
      inputError = "Enter valid email address";
      ref.notifyListeners();
      return;
    }
    identifier = value;
    type = "email";
  }

  state = const AsyncValue.loading();

  try {
    final response = await ref
        .read(authRepositoryProvider.notifier)
        .forgotPassword(identifier);

    // APIBASE handles errors. If we reach here → success
    navigationService.pushNamed(
      Routes.verifyOtp,
      arguments: VerifyOtpArguments(
        exchangeKey: response.exchangeKey,
        identifier: identifier,

      ),
    );
  } 
  catch(e){
    print('forgot password api error : $e');
  }
  finally {
    state = const AsyncValue.data(null);
  }
}


}
