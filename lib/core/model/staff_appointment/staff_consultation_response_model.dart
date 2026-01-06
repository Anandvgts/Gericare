import 'package:gericare_doctor/core/base/base_model.dart';
import 'staff_appointment_model.dart';

class StaffConsultationResponseModel extends BaseModel {
  late String date;
  late int staffId;
  late String staffName;
  late int totalSlots;
  late int bookedSlots;
  late List<StaffAppointmentModel> appointments;

  @override
  StaffConsultationResponseModel fromJson(Map<String, dynamic> json) {
    date = json['date'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    totalSlots = json['total_slots'];
    bookedSlots = json['booked_slots'];

    appointments = (json['appointments'] as List)
        .map((e) => StaffAppointmentModel().fromJson(e))
        .toList();

    return this;
  }
}
