import 'dart:core';

class ErrorResponseException implements Exception {
  bool? success;
  String? error;
  List<String>? errors;
  List<String>? codes;

  ErrorResponseException({this.success, this.error, this.errors, this.codes});

  ErrorResponseException.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    // Handle both single error message and array of errors
    if (json['error'] != null) {
      if (json['error'] is String) {
        error = json['error'];
      } else if (json['error'] is Map && json['error']['message'] != null) {
        error = json['error']['message'];
      } else if (json['error'] is List && (json['error'] as List).isNotEmpty) {
        // API returns: {"error":["Invalid credentials provided."]}
        errors = (json['error'] as List).map((e) => e.toString()).toList();
        error = errors!.first; // Set primary error message
      }
    }

    // Handle errors array
    if (json['errors'] != null && json['errors'] is List) {
      errors = (json['errors'] as List).map((e) => e.toString()).toList();
      if (error == null && errors!.isNotEmpty) {
        error = errors!.first;
      }
    }

    // Handle error codes
    if (json['code'] != null && json['code'] is List) {
      codes = (json['code'] as List).map((e) => e.toString()).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    data['errors'] = errors;
    data['codes'] = codes;
    return data;
  }

  @override
  String toString() {
    return 'ErrorResponseException{success: $success, error: $error, errors: $errors, codes: $codes}';
  }
}
