import 'package:gericare_doctor/core/model/staff_appointment/staff_consultation_response_model.dart';
import 'package:gericare_doctor/services/api/api_model/request_method.dart';
import 'package:intl/intl.dart';
import 'package:gericare_doctor/services/api/api_service.dart';
import 'package:gericare_doctor/services/api/api_model/request_settings.dart';
class StaffConsultationService {
  final ApiService _api;

  StaffConsultationService(this._api);

  Future<StaffConsultationResponseModel> fetchConsultations({
    required int staffId,
    required DateTime date,
  }) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return _api.request<StaffConsultationResponseModel>(
      RequestSettings(
        RequestMethod.GET,
        '/staff/v1/staff-consultation-list/?staff_id=$staffId&date=$formattedDate',
      ),
    );
  }
}
