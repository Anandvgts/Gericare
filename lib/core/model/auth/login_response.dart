import 'package:gericare_doctor/core/base/base_model.dart';

class LoginRequestModel extends BaseModel {
  final String identifier;
  final String password;

  LoginRequestModel({
    required this.identifier,
    required this.password,
  });

  @override
  Map<String, dynamic> toRequestParam() {
    return {
      "identifier": identifier,
      "password": password,
    };
  }
}
