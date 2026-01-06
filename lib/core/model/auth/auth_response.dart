import 'package:gericare_doctor/core/base/base_model.dart';
import 'package:gericare_doctor/core/model/user_model.dart';


class AuthResponseModel extends BaseModel {
  late String token;
  late UserModel user;

  @override
  AuthResponseModel fromJson(Map<String, dynamic> json) {
    final rawToken = json['token'] as String;

    token = rawToken.contains(':')
        ? rawToken.split(':').last
        : rawToken;
    user = UserModel().fromJson(json['user']);
    return this;
  }

  
}
