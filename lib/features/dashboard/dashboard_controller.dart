import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:doctor/core/enums/care_type.dart';

part 'dashboard_controller.g.dart';

class PatientSchedule {
  final String patientId;
  final String name;
  final String ward;
  final bool completed;
  final CareType careType;
  final PaymentStatus paymentStatus;
  final AppointmentStatus appointmentStatus;
  final String gender;
  final int age;
  final String timeSlot;
  final String serviceName;
  final String centreName;
  final String uhid;

  PatientSchedule({
    required this.patientId,
    required this.name,
    required this.ward,
    required this.completed,
    this.careType = CareType.al,
    this.paymentStatus = PaymentStatus.unpaid,
    this.appointmentStatus = AppointmentStatus.upcoming,
    this.gender = 'Male',
    this.age = 0,
    this.timeSlot = '',
    this.serviceName = '',
    this.centreName = '',
    this.uhid = '',
  });
}

@riverpod
class DashboardController extends _$DashboardController {
  DateTime selectedDate = DateTime.now();

   String userName = "";
   String greeting = "";

  int totalPatients = 8;
  int completedPatients = 3;

  List<PatientSchedule> schedules = [];

  @override
  AsyncValue<void> build() {
    _init();
    return const AsyncValue.data(null);
  }

  void _init() {
    final user = sessionService.currentUser;

    userName = user?.userName ?? "User";
    greeting = _getGreeting();

    /// Mock data for now (can be API later)
    schedules = [
      PatientSchedule(
        patientId: '001',
        name: "Mr. Krishna Kumar",
        ward: "Ward A - 108 B",
        completed: true,
        careType: CareType.al,
        paymentStatus: PaymentStatus.paid,
        appointmentStatus: AppointmentStatus.completed,
        gender: 'Male',
        age: 74,
        timeSlot: '09:00 AM - 09:30 AM',
        serviceName: 'Assisted Living Care',
        centreName: 'Main Centre',
        uhid: '1000001010',
      ),
      PatientSchedule(
        patientId: '002',
        name: "Mr Nandanam",
        ward: "Velachery AL",
        completed: false,
        careType: CareType.op,
        paymentStatus: PaymentStatus.unpaid,
        appointmentStatus: AppointmentStatus.upcoming,
        gender: 'Male',
        age: 50,
        timeSlot: '11:20 AM - 11:40 AM',
        serviceName: 'DOCTOR CONSULTATION A',
        centreName: 'Velachery AL',
        uhid: '1000001012',
      ),
      PatientSchedule(
        patientId: '003',
        name: "Mr Bharu",
        ward: "QA Centre",
        completed: false,
        careType: CareType.homeCare,
        paymentStatus: PaymentStatus.unpaid,
        appointmentStatus: AppointmentStatus.upcoming,
        gender: 'Male',
        age: 23,
        timeSlot: '03:55 AM - 04:00 AM',
        serviceName: 'GST APPLICABLE TEST 1',
        centreName: 'QA Centre',
        uhid: '1000001015',
      ),
    ];
  }

  String _getGreeting() {
  final hour = DateTime.now().hour;

  if (hour < 12) return "Good Morning!";
  if (hour < 17) return "Good Afternoon!";
  return "Good Evening!";
}


  String get formattedDate =>
      DateFormat('EEEE, d MMM').format(selectedDate);

  void onDateSelected(DateTime date) {
    selectedDate = date;
    ref.notifyListeners();
  }

  void onNotificationTap() {
    // future notification logic
  }

  void onScanTap() {
    navigationService.pushNamed(Routes.qrScan);
  }

  /// Navigate based on care type
  void onScheduleTap(PatientSchedule schedule) {
    switch (schedule.careType) {
      case CareType.op:
        // Navigate to OP consultation flow
        navigationService.pushNamed(
          Routes.opConsultation,
          arguments: schedule,
        );
        break;
      case CareType.al:
      case CareType.homeCare:
        // Navigate to existing AL consultation flow
        navigationService.pushNamed(
          Routes.consultation,
          arguments: schedule.patientId,
        );
        break;
    }
  }
}
