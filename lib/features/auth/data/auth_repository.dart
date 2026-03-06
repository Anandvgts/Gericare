import 'dart:async';

import 'package:doctor/features/auth/models/forgot_password.dart';
import 'package:doctor/features/auth/models/login.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/services/api_requests/auth_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
class AuthRepository extends _$AuthRepository {
  @override
  build() {
    return null;
  }

  final AuthRequest authRequest = AuthRequest();

  Future<Login> login(String identifier, String password) =>
      apiBaseService.request<Login>(authRequest.login(identifier, password),
          (data) => Login.formJson(data as Map<String, dynamic>));

  Future<ForgotPasswordResponse> forgotPassword(String identifier) =>
      apiBaseService.request<ForgotPasswordResponse>(
          authRequest.forgotPasswordSendOtp(identifier),
          (data) =>
              ForgotPasswordResponse.fromJson(data as Map<String, dynamic>));

  Future<Map<String, dynamic>> verifyOtp(String exchangeKey, String otp) =>
      apiBaseService.request(authRequest.verifyOtp(exchangeKey, otp),
          (data) => data as Map<String, dynamic>);
  Future<Map<String, dynamic>> resetPassword(
          String exchangeKey, String newPassword, String confirmPassword) =>
      apiBaseService.request(
          authRequest.resetPassword(exchangeKey, newPassword, confirmPassword),
          (data) => data as Map<String, dynamic>);
  Future<Map<String, dynamic>> logout() => apiBaseService.request(
      authRequest.logout(), (data) => data as Map<String, dynamic>);
}
