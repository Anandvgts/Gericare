
class ErrorResponse {

  String? message;
  Map<String, List<String>>? validationErrors;
  int? statusCode;

  ErrorResponse();

  ErrorResponse.fromResponse(Map<String, dynamic>? response, int statusCode, [bool identityResponse = false]) {
    var errorModel;
    if (response != null) {
      if (response.containsKey("error")) {
        errorModel = _ErrorModel.fromJson(response["error"]);
      }
      else {
        print("dfsssfsfs");
        errorModel = _ErrorModel.fromJson(response);
      }
    }
    if (errorModel != null) {
      message = errorModel.message;
      validationErrors = errorModel.errors;
    }
    statusCode = statusCode;
  }

  String getSingleMessage() {
    print(message);
    if (validationErrors == null) {
      return message ?? '';
    }
    return message ?? '';
  }
  @override
  String toString() {
    return message ?? '' + getSingleMessage();
  }
}

class _ErrorModel {

  String? message;
  Map<String, List<String>>? errors;

  _ErrorModel.fromJson(Map<String, dynamic> json) {
    errors =  Map<String, List<String>>();

   /* if (json['message'] is List) {
      message = (json['message'] as List)?.first ?? "No Message";
    }*/
    if (json["message"] is List<dynamic>) {
      List data = json["message"] as List<dynamic>;
      message = data[0].toString();
    }
    else if (json['message'] is String) {
      message = json['message'];
    }

    if (json['error']!=null){
      for (var key in json['error'].keys) {
        errors?[key] = List<String>.from(json['error'][key]);
      }
    }

  }
}