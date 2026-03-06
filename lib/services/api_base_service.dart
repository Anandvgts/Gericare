import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:doctor/core/config/app_config.dart';
import 'package:doctor/router.dart';
import 'package:doctor/services/snackbar_service.dart';
import 'package:doctor/utils/api_base_helper.dart';
import 'package:doctor/utils/logger.dart';

import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../locator.dart';
import '../core/models/request_settings.dart';

class ApiBaseService extends ApiBaseHelper {
  final baseUrl = AppConfig.instance.baseUrl;

  late Dio _dio;

  ApiBaseService() {
    init();
  }

  void init() {
    _dio = Dio();

    if (kDebugMode || kProfileMode || kReleaseMode) {
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true));
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final authenticated = options.extra['authenticated'] as bool? ?? true;

          if (authenticated) {
            final token = sessionService.token;
            if (token.isNotEmpty) {
              options.headers['Authorization'] = 'KNOX $token';
            }

            print('KNOX $token');
          }

          return handler.next(options);
        },
        onError: (error, handler) {
          _handleError(error);
          return handler.next(error);
        },
      ),
    );
    loggerService.log(LogLevel.debug.name, 'Api Base intialized',
        DateTime.now().toIso8601String());
  }

  @override
  Future<T> request<T>(
      RequestSettings settings, T Function(dynamic data) builder) async {
    try {
      final response = await _sendRequest(settings);

      if (response != null && _isSuccessful(response.statusCode)) {
        // Handle 204 & empty
        if (response.statusCode == 204 ||
            response.data == null ||
            response.data == "") {
          return builder(<String, dynamic>{}); // empty map
        }

        // Handle non-map string
        if (response.data is String) {
          try {
            return builder(jsonDecode(response.data));
          } catch (_) {
            return builder(<String, dynamic>{});
          }
        }

        return builder(response.data);
      }

      String errorMessage =
          'Request failed with status: ${response?.statusCode}';

      if (response?.data != null) {
        final responseData = response!.data;

        // Check if response is HTML (Django debug page)
        if (responseData is String && responseData.trim().startsWith('<')) {
          errorMessage = 'Server error occurred. Please try again later.';
          debugPrint('HTML Error Response received for ${settings.endPoint}');
        } else if (responseData is Map) {
          final err = responseData['error'] ??
              responseData['message'] ??
              responseData['detail'];

          if (err is List && err.isNotEmpty) {
            errorMessage = err.first.toString();
          } else if (err != null) {
            errorMessage = err.toString();
          }
        } else if (responseData is String && responseData.length < 200) {
          errorMessage = responseData;
        }
      }

      snackBarService.showSnackbar(
          message: errorMessage, snakBarType: SnackbarType.error);

      throw Exception(errorMessage);
    } on DioException catch (e) {
      rethrow;
    } on TimeoutException {
      snackBarService.showSnackbar(
          message: 'Connection timeout. Please try again.',
          snakBarType: SnackbarType.error);
      rethrow;
    } catch (e) {
      print('API Request error: $e');
      // Only rethrow if it's not already handled
      if (e is! Exception) {
        rethrow;
      }
      rethrow;
    }
  }

  @override
  Future<List<T>> requestList<T>(
      RequestSettings settings, List<T> Function(dynamic data) builder) async {
    try {
      final response = await _sendRequest(settings);

      if (response != null && _isSuccessful(response.statusCode)) {
        return builder(response.data);
      }

      // Extract error message from response
      String errorMessage =
          'Request failed with status: ${response?.statusCode}';
      if (response?.data != null) {
        final responseData = response!.data;
        if (responseData is Map) {
          final err = responseData['error'] ?? responseData['message'];

          if (err is List && err.isNotEmpty) {
            errorMessage = err.first.toString();
          } else if (err != null) {
            errorMessage = err.toString();
          }
        } else if (responseData is String) {
          errorMessage = responseData;
        }
      }

      // Show error in snackbar
      snackBarService.showSnackbar(
          message: errorMessage, snakBarType: SnackbarType.error);

      final dioError = DioException(
        requestOptions: RequestOptions(path: settings.endPoint),
        response: response,
        type: DioExceptionType.badResponse,
      );

      throw dioError;
    } on TimeoutException {
      snackBarService.showSnackbar(
          message: 'Connection timeout. Please try again.',
          snakBarType: SnackbarType.error);
      rethrow;
    } catch (e) {
      debugPrint('API Request error: $e');
      // Only rethrow if it's not already handled
      if (e is! Exception) {
        rethrow;
      }
      rethrow;
    }
  }

  Future<Response?> _sendRequest(RequestSettings settings) async {
    final endpoint = settings.endPoint.startsWith('http')
        ? settings.endPoint
        : baseUrl + settings.endPoint;
    print(
        'Send Request method -> ${getMethod(settings.method)} & Endpoint -> $endpoint');
    print('Authenticated:  ${settings.authenticated}');

    final options = createOptions(method: getMethod(settings.method));

    options.extra ??= {};
    options.extra!['authenticated'] = settings.authenticated;

    try {
      return await _dio.request(endpoint,
          data: settings.params, options: options);
    } catch (e) {
      print('Request Sent failed: $e');
      rethrow;
    }
  }

  bool _isSuccessful(int? statusCode) {
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }

  void _handleError(DioException e) {
    String message = 'An error occured';

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Server Connention timeout';
        break;

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;

        // Handle different status codes
        if (statusCode == 500) {
          message = 'Server error. Please try again later.';
        } else if (statusCode == 404) {
          message = 'Endpoint not found';
        } else if (statusCode == 401) {
          message = 'Unauthorized. Please login again.';
          sessionService.clearSession();

          navigationService.popAllAndPushNamed(Routes.login);
          return;
        } else if (responseData != null) {
          // Check if response is HTML (Django debug page)
          if (responseData is String && responseData.trim().startsWith('<')) {
            message = 'Server error occurred. Please contact support.';
            // Log the actual error for debugging
            debugPrint(
                'HTML Error Response: ${responseData.substring(0, 500)}');
          } else if (responseData is Map) {
            final err = responseData['error'] ??
                responseData['message'] ??
                responseData[
                    'detail'] ?? // Add 'detail' for Django REST Framework
                'Server error';

            if (err is List && err.isNotEmpty) {
              message = err.first.toString();
            } else {
              message = err.toString();
            }
          } else if (responseData is String) {
            // Limit string length to prevent huge error messages
            message = responseData.length > 100
                ? '${responseData.substring(0, 100)}...'
                : responseData;
          } else {
            message = 'Server error';
          }
        } else {
          message = 'Something went wrong on server';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection';
        break;
      default:
        message = 'Something went wrong';
    }

    loggerService.log(
        LogLevel.debug.name, message, DateTime.now().toIso8601String());

    snackBarService.showSnackbar(
        message: message, snakBarType: SnackbarType.error);
  }

  void clearCache() {
    try {
      _dio.interceptors.clear();

      _dio.close(force: true);

      loggerService.log(LogLevel.debug.name, 'Api cache cleared',
          DateTime.now().toIso8601String());

      init();
    } catch (e) {
      loggerService.log(LogLevel.debug.name, 'Error clearing API cache: $e',
          DateTime.now().toIso8601String());
    }
  }
}
