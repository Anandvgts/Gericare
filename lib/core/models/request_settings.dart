import 'package:doctor/core/enums/request_method.dart';

class RequestSettings {
  final RequestMethod method;
  final String endPoint;
  final Object? params;
  final bool authenticated;

  RequestSettings({
    required this.method,
    required this.endPoint,
    this.params,
    this.authenticated = true,
  });

  RequestSettings copyWith({
    RequestMethod? method,
    String? endPoint,
    Object? params,
    bool? authenticated,
  }) {
    return RequestSettings(
      method: method ?? this.method,
      endPoint: endPoint ?? this.endPoint,
      params: params ?? this.params,
      authenticated: authenticated ?? this.authenticated,
    );
  }
}
