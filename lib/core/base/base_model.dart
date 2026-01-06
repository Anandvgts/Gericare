import 'package:gericare_doctor/core/model/auth/auth_response.dart';
import 'package:gericare_doctor/core/model/staff_appointment/staff_appointment_model.dart';
import 'package:gericare_doctor/core/model/staff_appointment/staff_consultation_response_model.dart';
import 'package:gericare_doctor/core/model/user_model.dart';
import 'package:vgts_plugin/form/base_object.dart';

class BaseModel extends BaseObject {
  BaseModel();

  BaseModel fromJson(Map<String, dynamic> json) {
    throw ("fromJson not implemented");
  }

  Map<String, dynamic> toJson() {
    throw ("toJson not implemented");
  }

  Map<String, dynamic> toRequestParam() {
    throw ("toRequestParam not implemented");
  }

  static T object<T extends BaseModel>() {
    switch (T) {
      case AuthResponseModel:
        return AuthResponseModel() as T;
      case UserModel:
        return UserModel() as T;
      case StaffConsultationResponseModel:
      return StaffConsultationResponseModel() as T;
    case StaffAppointmentModel:
      return StaffAppointmentModel() as T;
    }
    throw "Requested Model not initialised in BaseModel";
  }

  static createFromMap<T extends BaseModel>(Map<String, dynamic> data) {
    return object<T>().fromJson(data);
  }
}
