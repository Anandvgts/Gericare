// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';

// final treatmentsViewModelProvider =
//     ChangeNotifierProvider.family<TreatmentsViewModel, String>(
//   (ref, patientId) => TreatmentsViewModel(patientId),
// );

// class TreatmentItem {
//   final DateTime dateTime;
//   final String title;
//   final String subtitle;
//   final String therapist;
//   final String referredBy;

//   TreatmentItem({
//     required this.dateTime,
//     required this.title,
//     required this.subtitle,
//     required this.therapist,
//     required this.referredBy,
//   });
// }

// class TreatmentsViewModel extends ChangeNotifier {
//   final String patientId;

//   TreatmentsViewModel(this.patientId) {
//     _loadTreatments();
//   }

//   DateTime selectedDate = DateTime.now();
//   final List<TreatmentItem> _treatments = [];

//   void _loadTreatments() {
//     _treatments.addAll([
//       /// TODAY
//       TreatmentItem(
//         dateTime: DateTime.now().copyWith(hour: 8, minute: 10),
//         title: "DBE/AAROM to B/L UL/LL",
//         subtitle: "Ambulate to WC",
//         therapist: "Dr. Harish Kanth",
//         referredBy: "Dr. Krishna Kumar",
//       ),

//       /// YESTERDAY
//       TreatmentItem(
//         dateTime: DateTime.now().subtract(const Duration(days: 1)).copyWith(
//               hour: 12,
//               minute: 35,
//             ),
//         title: "DBE/AAROM to B/L UL/LL",
//         subtitle: "",
//         therapist: "Dr. Harish Kanth",
//         referredBy: "Dr. Krishna Kumar",
//       ),

//       /// TWO DAYS AGO
//       TreatmentItem(
//         dateTime: DateTime.now().subtract(const Duration(days: 2)).copyWith(
//               hour: 9,
//               minute: 20,
//             ),
//         title: "ROM Exercise",
//         subtitle: "",
//         therapist: "Dr. John",
//         referredBy: "Dr. Krishna Kumar",
//       ),
//     ]);

//     notifyListeners();
//   }

//   /// GROUP BY DATE
//   Map<DateTime, List<TreatmentItem>> get groupedTreatments {
//     final Map<DateTime, List<TreatmentItem>> map = {};

//     for (final item in _treatments) {
//       final dateKey = DateTime(
//         item.dateTime.year,
//         item.dateTime.month,
//         item.dateTime.day,
//       );

//       map.putIfAbsent(dateKey, () => []);
//       map[dateKey]!.add(item);
//     }

//     /// Sort by date DESC (latest first)
//     final sortedKeys = map.keys.toList()..sort((a, b) => b.compareTo(a));

//     return {
//       for (final key in sortedKeys) key: map[key]!,
//     };
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

//   String fullDate(DateTime date) => DateFormat("EEEE, d MMM").format(date);

//   String shortDate(DateTime date) {
//   return DateFormat('EEE, d MMM').format(date);
// }


//   String get formattedSelectedDate =>
//       DateFormat("EEEE, d MMM").format(selectedDate);
// }


import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatments_controller.g.dart';

/// ───────────── MODEL ─────────────

class TreatmentItem {
  final DateTime dateTime;
  final String title;
  final String subtitle;
  final String therapist;
  final String referredBy;

  TreatmentItem({
    required this.dateTime,
    required this.title,
    required this.subtitle,
    required this.therapist,
    required this.referredBy,
  });
}

/// ───────────── CONTROLLER ─────────────

@riverpod
class TreatmentsController extends _$TreatmentsController {
  // late final String patientId;

  DateTime selectedDate = DateTime.now();
  final List<TreatmentItem> _treatments = [];

  @override
  AsyncValue<void> build(String patientId) {
    // this.patientId = patientId;
    _loadTreatments();
    return const AsyncValue.data(null);
  }

  void _loadTreatments() {
    _treatments
      ..clear()
      ..addAll([
        /// TODAY
        TreatmentItem(
          dateTime: DateTime.now().copyWith(hour: 8, minute: 10),
          title: "DBE/AAROM to B/L UL/LL",
          subtitle: "Ambulate to WC",
          therapist: "Dr. Harish Kanth",
          referredBy: "Dr. Krishna Kumar",
        ),

        /// YESTERDAY
        TreatmentItem(
          dateTime: DateTime.now()
              .subtract(const Duration(days: 1))
              .copyWith(hour: 12, minute: 35),
          title: "DBE/AAROM to B/L UL/LL",
          subtitle: "",
          therapist: "Dr. Harish Kanth",
          referredBy: "Dr. Krishna Kumar",
        ),

        /// TWO DAYS AGO
        TreatmentItem(
          dateTime: DateTime.now()
              .subtract(const Duration(days: 2))
              .copyWith(hour: 9, minute: 20),
          title: "ROM Exercise",
          subtitle: "",
          therapist: "Dr. John",
          referredBy: "Dr. Krishna Kumar",
        ),
      ]);

    ref.notifyListeners();
  }

  /// ───────────── GROUPING ─────────────

  Map<DateTime, List<TreatmentItem>> get groupedTreatments {
    final Map<DateTime, List<TreatmentItem>> map = {};

    for (final item in _treatments) {
      final dateKey = DateTime(
        item.dateTime.year,
        item.dateTime.month,
        item.dateTime.day,
      );

      map.putIfAbsent(dateKey, () => []);
      map[dateKey]!.add(item);
    }

    final sortedKeys = map.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return {
      for (final key in sortedKeys) key: map[key]!,
    };
  }

  /// ───────────── HELPERS ─────────────

  void onDateSelected(DateTime date) {
    selectedDate = date;
    ref.notifyListeners();
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String shortDate(DateTime date) =>
      DateFormat('EEE, d MMM').format(date);

  String get formattedSelectedDate =>
      DateFormat("EEEE, d MMM").format(selectedDate);
}
