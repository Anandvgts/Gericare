import 'package:dio/dio.dart';
import 'package:doctor/core/enums/request_method.dart';
import 'package:doctor/core/models/request_settings.dart';

abstract class ApiBaseHelper {

  Future<T> request<T>(
    RequestSettings settings,
    T Function(dynamic data ) builder,
  );

  Future<List<T>> requestList<T>(
    RequestSettings settings,
    List<T> Function(dynamic data ) builder,
  );

  String getMethod(RequestMethod method){
    switch(method){
      case RequestMethod.GET:
        return 'GET';
      case RequestMethod.POST:
        return 'POST';
      case RequestMethod.PUT:
        return 'PUT';
      case RequestMethod.PATCH:
        return 'PATCH';
      case RequestMethod.DELETE:
        return 'DELETE';
    }
  }


  Options createOptions({
    required String method,Map<String,String>? headers,
  }){
    return Options(
      method: method,
      headers: headers,
      validateStatus: (status) => status! < 500,
    );
  }
}