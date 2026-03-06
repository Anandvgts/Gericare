// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:doctor/locator.dart';
// import 'package:doctor/router.dart';

// final incidentHistoryViewModelProvider =
//     ChangeNotifierProvider.family<IncidentHistoryViewModel, String>(
//   (ref, patientId) => IncidentHistoryViewModel(patientId),
// );

// class IncidentLog {
//   final DateTime dateTime;
//   final String title;
//   final String recordedBy;

//   IncidentLog({
//     required this.dateTime,
//     required this.title,
//     required this.recordedBy,
//   });
// }

// class IncidentHistoryViewModel extends ChangeNotifier {
//   final String patientId;

//   IncidentHistoryViewModel(this.patientId) {
//     _loadIncidents();
//   }

//   DateTime selectedDate = DateTime.now();

//   final List<IncidentLog> incidents = [];

//   void _loadIncidents() {
//     incidents.addAll([
//       IncidentLog(
//         dateTime: DateTime.now().copyWith(hour: 8, minute: 10),
//         title: "Incident Log 1",
//         recordedBy: "Priya Nair",
//       ),
//       IncidentLog(
//         dateTime: DateTime.now().copyWith(hour: 12, minute: 35),
//         title: "Incident Log 2",
//         recordedBy: "Vinay Kumar",
//       ),
//     ]);

//     notifyListeners();
//   }

//   void onDateSelected(DateTime date) {
//     selectedDate = date;
//     notifyListeners();
//   }

//   String get formattedSelectedDate =>
//       DateFormat("EEEE, d MMM").format(selectedDate);

//   void openIncident(IncidentLog log) {
//     navigationService.pushNamed(
//       Routes.csIncidentReport,
//       arguments: log,
//     );
//   }
// }

import 'package:doctor/features/consultation/case_sheet/incident/incident_report_view.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';

part 'incident_controller.g.dart';

/// ───────────── MODEL ─────────────

class IncidentLog {
  final DateTime dateTime;
  final String title;
  final String recordedBy;

  IncidentLog({
    required this.dateTime,
    required this.title,
    required this.recordedBy,
  });
}

/// ───────────── CONTROLLER ─────────────

@riverpod
class IncidentController extends _$IncidentController {
  // late final String patientId;

  DateTime selectedDate = DateTime.now();
  final List<IncidentLog> incidents = [];

  @override
  AsyncValue<void> build(String patientId) {
    // this.patientId = patientId;
    _loadIncidents();
    return const AsyncValue.data(null);
  }

  void _loadIncidents() {
    incidents
      ..clear()
      ..addAll([
        IncidentLog(
          dateTime: DateTime.now().copyWith(hour: 8, minute: 10),
          title: "Incident Log 1",
          recordedBy: "Priya Nair",
        ),
        IncidentLog(
          dateTime: DateTime.now().copyWith(hour: 12, minute: 35),
          title: "Incident Log 2",
          recordedBy: "Vinay Kumar",
        ),
      ]);

    ref.notifyListeners();
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
    ref.notifyListeners();
  }

  String get formattedSelectedDate =>
      DateFormat("EEEE, d MMM").format(selectedDate);

 void openIncident(IncidentLog log) {
  navigationService.pushNamed(
    Routes.csIncidentReport,
    arguments: IncidentReportArgs(
      patientName: "Mr. Krishna Kumar",
      dateLabel: DateFormat("EEE, MMM d yyyy").format(log.dateTime),
      type: "Fall",
      location: "Room 201",
      witness: "Nurse Priya",
      notes: "Patient slipped near washroom.",
      attachments: [
        "assets/sample/incident1.png",
        "assets/sample/incident2.png",
      ],
    ),
  );
}

}
