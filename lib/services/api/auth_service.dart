import 'package:gericare_doctor/core/model/auth/auth_response.dart';
import 'package:gericare_doctor/core/model/auth/login_response.dart';
import 'package:gericare_doctor/services/api/api_model/request_method.dart';
import 'package:gericare_doctor/services/api/api_service.dart';
import 'package:gericare_doctor/services/api/api_model/request_settings.dart';


class AuthService {
  final ApiService _api;

  AuthService(this._api);

  Future<AuthResponseModel> login({
    required String identifier,
    required String password,
  }) {
    return _api.request<AuthResponseModel>(
      RequestSettings(
        RequestMethod.POST,
        "/user/mobile/v1/login/",
        params: {
          "identifier": identifier,
          "password": password,
        },
        authenticated: false,
      ),
    );
  }
}

