import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';

part 'dashboard_controller.g.dart';

class PatientSchedule {
  final String patientId;
  final String name;
  final String ward;
  final bool completed;

  PatientSchedule({
    required this.patientId,
    required this.name,
    required this.ward,
    required this.completed,
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
        ward: "Ward A • 108 B",
        completed: true,
      ),
      PatientSchedule(
        patientId: '002',
        name: "Mr. Bala Subramanian",
        ward: "Ward A • 104 A",
        completed: false,
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
}
