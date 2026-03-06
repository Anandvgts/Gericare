// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';

// final bloodSugarViewModelProvider =
//     ChangeNotifierProvider.family<BloodSugarViewModel, String>(
//   (ref, patientId) => BloodSugarViewModel(patientId),
// );

// class BloodSugarLog {
//   final DateTime dateTime;
//   final int value;
//   final String note;
//   final String recordedBy;

//   BloodSugarLog({
//     required this.dateTime,
//     required this.value,
//     required this.note,
//     required this.recordedBy,
//   });
// }

// class BloodSugarViewModel extends ChangeNotifier {
//   final String patientId;

//   BloodSugarViewModel(this.patientId) {
//     _loadLogs();
//   }

//   DateTime selectedDate = DateTime.now();
//   final List<BloodSugarLog> _logs = [];

//   void _loadLogs() {
//     _logs.addAll([
//       BloodSugarLog(
//         dateTime: DateTime.now().copyWith(hour: 8, minute: 10),
//         value: 108,
//         note: "No order",
//         recordedBy: "Priya Nair",
//       ),
//       BloodSugarLog(
//         dateTime: DateTime.now().copyWith(hour: 12, minute: 35),
//         value: 106,
//         note: "Before Food",
//         recordedBy: "Priya Nair",
//       ),
//     ]);

//     notifyListeners();
//   }

//   Map<DateTime, List<BloodSugarLog>> get groupedLogs {
//     final map = <DateTime, List<BloodSugarLog>>{};

//     for (final log in _logs) {
//       final key = DateTime(log.dateTime.year, log.dateTime.month, log.dateTime.day);
//       map.putIfAbsent(key, () => []).add(log);
//     }

//     final sortedKeys = map.keys.toList()..sort((a, b) => b.compareTo(a));
//     return {for (final k in sortedKeys) k: map[k]!};
//   }

//   bool isToday(DateTime date) {
//     final now = DateTime.now();
//     return date.year == now.year &&
//         date.month == now.month &&
//         date.day == now.day;
//   }

//   void onDateSelected(DateTime date) {
//     selectedDate = date;
//     notifyListeners();
//   }

//   String shortDate(DateTime date) => DateFormat("EEE, d MMM").format(date);

//   String get formattedSelectedDate =>
//       DateFormat("EEEE, d MMM").format(selectedDate);
// }



import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blood_sugar_controller.g.dart';

/// ───────────── MODEL ─────────────

class BloodSugarLog {
  final DateTime dateTime;
  final int value;
  final String note;
  final String recordedBy;

  BloodSugarLog({
    required this.dateTime,
    required this.value,
    required this.note,
    required this.recordedBy,
  });
}

/// ───────────── CONTROLLER ─────────────

@riverpod
class BloodSugarController extends _$BloodSugarController {
  // late final String patientId;

  DateTime selectedDate = DateTime.now();
  final List<BloodSugarLog> _logs = [];

  @override
  AsyncValue<void> build(String patientId) {
    // this.patientId = patientId;
    _loadLogs();
    return const AsyncValue.data(null);
  }

  void _loadLogs() {
    _logs
      ..clear()
      ..addAll([
        BloodSugarLog(
          dateTime: DateTime.now().copyWith(hour: 8, minute: 10),
          value: 108,
          note: "No order",
          recordedBy: "Priya Nair",
        ),
        BloodSugarLog(
          dateTime: DateTime.now().copyWith(hour: 12, minute: 35),
          value: 106,
          note: "Before Food",
          recordedBy: "Priya Nair",
        ),
      ]);

    ref.notifyListeners();
  }

  /// ───────────── GROUPING ─────────────

  Map<DateTime, List<BloodSugarLog>> get groupedLogs {
    final map = <DateTime, List<BloodSugarLog>>{};

    for (final log in _logs) {
      final key = DateTime(
        log.dateTime.year,
        log.dateTime.month,
        log.dateTime.day,
      );
      map.putIfAbsent(key, () => []).add(log);
    }

    final sortedKeys = map.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return {for (final k in sortedKeys) k: map[k]!};
  }

  /// ───────────── HELPERS ─────────────

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
    ref.notifyListeners();
  }

  String shortDate(DateTime date) =>
      DateFormat("EEE, d MMM").format(date);

  String get formattedSelectedDate =>
      DateFormat("EEEE, d MMM").format(selectedDate);
}
