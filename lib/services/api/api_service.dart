import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gericare_doctor/services/shared/dialog_service.dart';
import 'package:http/http.dart' as HTTP;

import 'package:gericare_doctor/core/base/base_model.dart';
import 'package:gericare_doctor/core/model/exception/api_error_response.dart';
import 'package:gericare_doctor/locator.dart';
import 'package:gericare_doctor/router.dart';
import 'package:gericare_doctor/services/shared/preferences_service.dart';

import 'api_base_helper.dart';
import 'api_model/error_response_exception.dart';
import 'api_model/no_response_exception.dart';
import 'api_model/request_settings.dart';

class ApiService extends ApiBaseHelper {
  // static const String baseUrl = 'https://dev.api.gericare.techdemo.in/';
  static const String baseUrl = 'https://df423d1078bd.ngrok-free.app';

  final PreferenceService _pref = locator<PreferenceService>();
  final DialogService _dialog = locator<DialogService>();
  final HTTP.Client _client = HTTP.Client();

  /* ========================== SINGLE OBJECT ========================== */

  Future<T> request<T extends BaseModel>(RequestSettings settings) async {
    try {
      final response = await _send(
        settings.method,
        settings.endPoint,
        settings.params,
        authenticated: settings.authenticated,
      );

      if (response != null && _isSuccess(response.statusCode)) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;

        return BaseModel.createFromMap<T>(data);
      }
    } on SocketException {
      _showNoInternet();
      throw NoResponseException(message: "No internet connection");
    } on TimeoutException {
      _showServerError();
      throw NoResponseException(message: "Request timeout");
    } on ErrorResponseException {
      // Re-throw ErrorResponseException so it can be caught by the caller
      rethrow;
    }

    throw NoResponseException(message: "No response from server");
  }

  /* =========================== LIST OBJECT ============================ */

  Future<List<T>> requestList<T extends BaseModel>(
      RequestSettings settings) async {
    try {
      final response = await _send(
        settings.method,
        settings.endPoint,
        settings.params,
        authenticated: settings.authenticated,
      );

      if (response != null && _isSuccess(response.statusCode)) {
        final List list = jsonDecode(response.body);
        return list
            .map((e) => BaseModel.createFromMap<T>(e))
            .cast<T>()
            .toList();
      }
    } on SocketException {
      _showNoInternet();
      throw NoResponseException(message: "No internet connection");
    } on TimeoutException {
      _showServerError();
      throw NoResponseException(message: "Request timeout");
    } on ErrorResponseException {
      // Re-throw ErrorResponseException so it can be caught by the caller
      rethrow;
    }

    throw NoResponseException(message: "No response from server");
  }

  /* ============================== CORE ================================ */

  Future<HTTP.Response?> _send(
    String method,
    String endPoint,
    Object? body, {
    bool authenticated = true,
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      baseUrl +
          endPoint +
          (queryParams != null ? Uri(queryParameters: queryParams).query : ''),
    );

    final request = HTTP.Request(method, uri);

    if (!(body is HTTP.MultipartRequest)) {
      request.body = body is String ? body : serialize(body);
    }

    request.headers.addAll(await _headers(authenticated));

    final streamed = await _client
        .send(body is HTTP.MultipartRequest ? body : request)
        .timeout(const Duration(seconds: 30));

    return _handleResponse(await HTTP.Response.fromStream(streamed));
  }

  /* =========================== RESPONSE =============================== */

  Future<HTTP.Response?> _handleResponse(HTTP.Response response) async {
    debugPrint(response.body);

    if (_isSuccess(response.statusCode)) return response;

    if (response.statusCode == 401) {
      // Session expired - Clear data and navigate to login
      // await _pref.clearData();
      Fluttertoast.showToast(msg: "Session expired. Please login again");
      navigationService.popAllAndPushNamed(Routes.login);
      return null;
    }

    if (response.statusCode >= 400 && response.statusCode < 500) {
      // Parse the error response
      Map<String, dynamic>? errorJson;
      try {
        errorJson = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        debugPrint("Failed to parse error response: $e");
      }

      // Create and throw ErrorResponseException
      final exception = ErrorResponseException.fromJson(errorJson ?? {});

      // Optionally show dialog for non-login errors
      // (you might want to skip this for login to avoid double error display)
      // _showApiDialog(await handleApiError(response, false));

      throw exception;
    }

    if (response.statusCode >= 500) {
      Fluttertoast.showToast(
          msg: "Service unavailable. Please try again later");
      throw NoResponseException(message: "Server error");
    }

    throw NoResponseException(message: "Unknown error occurred");
  }

  /* ============================= HEADERS ============================== */

  Future<Map<String, String>> _headers(bool authenticated) async {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (authenticated) {
      final token = await _pref.getBearerToken();
      if (token != null && token.isNotEmpty) {
        print('KNOX WEB:$token');
        headers['Authorization'] = 'KNOX WEB:$token'; // API KEY auth
      }
    }

    return headers;
  }

  /* ============================= HELPERS ============================== */

  bool _isSuccess(int code) => code >= 200 && code < 300;

  void _showNoInternet() =>
      Fluttertoast.showToast(msg: "No internet connection");

  void _showServerError() {
    _dialog.showDialog(
      title: "Server Error",
      description: "Unable to connect to server",
    );
  }

  void _showApiDialog(ErrorResponse? error) {
    if (error?.getSingleMessage() != null) {
      _dialog.showDialog(
        title: error?.message ?? "Error",
        description: error!.getSingleMessage(),
      );
    }
  }
}
