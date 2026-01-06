// import 'package:flutter/material.dart';
// import 'package:gericare_doctor/core/base/base_view_model.dart';
// import 'package:gericare_doctor/router.dart';
// import 'package:gericare_doctor/ui/views/dashboard/qr_scanner_view.dart';
// import 'package:intl/intl.dart';

// /// Model class for patient schedule
// class PatientSchedule {
//   final String id;
//   final String name;
//   final String ward;
//   final String category;
//   final bool completed;

//   PatientSchedule({
//     required this.id,
//     required this.name,
//     required this.ward,
//     this.category = "Assisted Living",
//     this.completed = false,
//   });
// }

// class DashboardViewModel extends VGTSBaseViewModel {
//   // Selected date for calendar
//   DateTime _selectedDate = DateTime.now();
//   DateTime get selectedDate => _selectedDate;

//   // Patient statistics
//   int _totalPatients = 8;
//   int get totalPatients => _totalPatients;

//   int _completedPatients = 3;
//   int get completedPatients => _completedPatients;

//   // Schedule list
//   List<PatientSchedule> _schedules = [
//     PatientSchedule(
//       id: "1",
//       name: "Mr. Krishna Kumar",
//       ward: "Ward A • 108 B",
//       category: "Assisted Living",
//       completed: true,
//     ),
//     PatientSchedule(
//       id: "2",
//       name: "Mr. Bala Subramanian",
//       ward: "Ward A • 104 A",
//       category: "Assisted Living",
//       completed: false,
//     ),
//     PatientSchedule(
//       id: "3",
//       name: "Mr. Krishna Kumar",
//       ward: "Ward A • 108 B",
//       category: "Assisted Living",
//       completed: false,
//     ),
//   ];

//   List<PatientSchedule> get schedules => _schedules;

//   /// Called when user selects a date from the calendar
//   void onDateSelected(DateTime date) {
//     _selectedDate = date;
//     notifyListeners();

//     // TODO: Fetch schedules for the selected date
//     _fetchSchedulesForDate(date);
//   }

//   /// Navigate to notification screen
//   void onNotificationTap() {
//     // TODO: Implement navigation to notification screen
//     // navigationService.navigateTo(Routes.notificationView);
//   }

//   /// Open QR scanner
//   Future<void> onScanTap(BuildContext context) async {
//     navigationService.pushNamed(Routes.consultation);

//     // final result = await Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (_) => const QrScannerView()),
//     // );

//     // if (result != null) {
//     //   // result = QR data
//     //   print("Scanned QR: $result");

//     //   // TODO:
//     //   // Parse patient ID
//     //   // Navigate to patient details screen
//     // }
//   }

//   /// Get formatted date string (e.g., "Wednesday, 7 Nov")
//   String getFormattedDate() {
//     return DateFormat('EEEE, d MMM').format(_selectedDate);
//   }

//   /// Calculate and return completion percentage
//   int getCompletionPercentage() {
//     if (_totalPatients == 0) return 0;
//     return ((_completedPatients / _totalPatients) * 100).round();
//   }

//   /// Fetch schedules for a specific date
//   Future<void> _fetchSchedulesForDate(DateTime date) async {
//     // TODO: Implement API call to fetch schedules
//     // setBusy(true);
//     // try {
//     //   final result = await _apiService.getSchedules(date);
//     //   _schedules = result;
//     //   _updatePatientStats();
//     //   notifyListeners();
//     // } catch (e) {
//     //   // Handle error
//     // } finally {
//     //   setBusy(false);
//     // }
//   }

//   /// Update patient statistics based on schedules
//   void _updatePatientStats() {
//     _totalPatients = _schedules.length;
//     _completedPatients = _schedules.where((s) => s.completed).length;
//     notifyListeners();
//   }

//   /// Mark a schedule as completed
//   void markScheduleCompleted(String scheduleId) {
//     final index = _schedules.indexWhere((s) => s.id == scheduleId);
//     if (index != -1) {
//       _schedules[index] = PatientSchedule(
//         id: _schedules[index].id,
//         name: _schedules[index].name,
//         ward: _schedules[index].ward,
//         category: _schedules[index].category,
//         completed: true,
//       );
//       _updatePatientStats();
//     }
//   }

//   /// Navigate to patient detail screen
//   void onScheduleTap(PatientSchedule schedule) {
//     // TODO: Navigate to patient detail screen
//     // navigationService.navigateTo(
//     //   Routes.patientDetailView,
//     //   arguments: PatientDetailArguments(patientId: schedule.id),
//     // );
//   }

//   @override
//   void dispose() {
//     // Clean up resources if needed
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/locator.dart';
import 'package:gericare_doctor/router.dart';
import 'package:gericare_doctor/services/api/staff_consultation_service.dart';
import 'package:gericare_doctor/services/shared/preferences_service.dart';
import 'package:intl/intl.dart';

class PatientSchedule {
  final String name;
  final String ward;
  final bool completed;

  PatientSchedule({
    required this.name,
    required this.ward,
    required this.completed,
  });
}

class DashboardViewModel extends VGTSBaseViewModel {
  final StaffConsultationService _service = locator<StaffConsultationService>();
  final PreferenceService _pref = locator<PreferenceService>();

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  int _totalSlots = 0;
  int get totalPatients => _totalSlots;

  int _bookedSlots = 0;
  int get completedPatients => _bookedSlots;

  List<PatientSchedule> _schedules = [];
  List<PatientSchedule> get schedules => _schedules;

  @override
  Future onInit() async {
    super.onInit();
    await _fetchSchedulesForDate(_selectedDate);
  }

  /// Navigate to notification screen
  void onNotificationTap() {
    // TODO: Implement navigation to notification screen
    // navigationService.navigateTo(Routes.notificationView);
  }

  /// Open QR scanner
  Future<void> onScanTap(BuildContext context) async {
    navigationService.pushNamed(Routes.consultation);

    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => const QrScannerView()),
    // );

    // if (result != null) {
    //   // result = QR data
    //   print("Scanned QR: $result");

    //   // TODO:
    //   // Parse patient ID
    //   // Navigate to patient details screen
    // }
  }

  void onDateSelected(DateTime date) {
    _selectedDate = date;
    notifyListeners();
    _fetchSchedulesForDate(date);
  }

  String getFormattedDate() {
    return DateFormat('EEEE, d MMM').format(_selectedDate);
  }

  int getCompletionPercentage() {
    if (_totalSlots == 0) return 0;
    return ((_bookedSlots / _totalSlots) * 100).round();
  }

  Future<void> _fetchSchedulesForDate(DateTime date) async {
    setBusy(true);

    try {
      final staffId = await _pref.getStaffId(); // MUST exist
      final response = await _service.fetchConsultations(
        staffId: staffId,
        date: date,
      );
      

      _totalSlots = response.totalSlots;
      _bookedSlots = response.bookedSlots;

      _schedules = response.appointments
          .map(
            (a) => PatientSchedule(
              name: a.patientName,
              ward: '${a.startTime} - ${a.endTime}',
              completed: a.completed,
            ),
          )
          .toList();
    } catch (e) {
      // error toast already handled globally
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }
}
