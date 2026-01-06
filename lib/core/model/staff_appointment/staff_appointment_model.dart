import 'package:gericare_doctor/core/base/base_model.dart';

class StaffAppointmentModel extends BaseModel {
  late int id;
  late String patientName;
  late String startTime;
  late String endTime;
  late bool completed;

  @override
  StaffAppointmentModel fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientName = json['patient_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    completed = json['payment_status_display'] == 'Completed';
    return this;
  }
}
