import 'package:doctor/core/enums/request_method.dart';
import 'package:doctor/core/models/request_settings.dart';

class AuthRequest {
  ///Login Page
  /// Login with identifier (email/phone/username) and password
  /// Endpoint: /user/mobile/v1/login/
  RequestSettings login(String identifier, String password) {
    final params = {
      "identifier": identifier,
      "password": password,
    };

    return RequestSettings(
        method: RequestMethod.POST,
        endPoint: "/user/mobile/v1/login/",
        params: params,
        authenticated: false);
  }

  ///Forgot password Page
  /// Forgot password - send OTP
  /// Endpoint: /user/mobile/v1/forget-password/send-otp/
  RequestSettings forgotPasswordSendOtp(String identifier) {
    final params = {
      "identifier": identifier,
    };

    return RequestSettings(
      method: RequestMethod.POST,
      endPoint: "/user/mobile/v1/forget-password/send-otp/",
      params: params,
      authenticated: false,
    );
  }

  ///Verify Otp screen
  /// Verify OTP for password reset
  /// Endpoint: /user/mobile/v1/forget-password/verify-otp/{exchange_key}/
  RequestSettings verifyOtp(String exchangeKey, String otp) {
    final params = {
      "otp": otp,
    };

    return RequestSettings(
      method: RequestMethod.PUT,
      endPoint: "/user/mobile/v1/forget-password/verify-otp/$exchangeKey/",
      params: params,
      authenticated: false,
    );
  }

  ///Reset password screen
  /// Reset password with new password
  /// Endpoint: /user/mobile/v1/reset-password/{exchange_key}/
  RequestSettings resetPassword(
      String exchangeKey, String newPassword, String confirmPassword) {
    final params = {
      "new_password": newPassword,
      "confirm_password": confirmPassword,
    };

    return RequestSettings(
      method: RequestMethod.PUT,
      endPoint: "/user/mobile/v1/reset-password/$exchangeKey/",
      params: params,
      authenticated: false,
    );
  }

  /// Logout - invalidate current session token
  /// Endpoint: /user/mobile/v1/logout/
  RequestSettings logout() {
    return RequestSettings(
      method: RequestMethod.DELETE,
      endPoint: "/user/mobile/v1/logout/",
      params: {},
      authenticated: true, // Requires token
    );
  }
}
