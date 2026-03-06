import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';

part 'vitals_controller.g.dart';

/// ───────────── MODELS ─────────────

class VitalsLog {
  final DateTime dateTime;
  final String title;
  final String recordedBy;

  VitalsLog({
    required this.dateTime,
    required this.title,
    required this.recordedBy,
  });
}

enum VitalStatus { normal, mild, moderate, hypotension, nonDiabetic }

class VitalValue {
  final String label;
  final String value;
  final String unit;
  final VitalStatus status;
  final bool fullWidth;

  VitalValue({
    required this.label,
    required this.value,
    required this.unit,
    required this.status,
    this.fullWidth = false,
  });
}

class VitalSection {
  final String title;
  final IconData icon;
  final List<VitalValue> values;

  VitalSection({
    required this.title,
    required this.icon,
    required this.values,
  });
}

/// ───────────── CONTROLLER ─────────────

@riverpod
class VitalsController extends _$VitalsController {
  DateTime selectedDate = DateTime.now();

  /// HISTORY
  final List<VitalsLog> logs = [];

  /// DETAIL
  VitalsLog? selectedLog;
  final List<VitalSection> sections = [];

  @override
  AsyncValue<void> build() {
    _loadHistory();
    return const AsyncValue.data(null);
  }

  /// ───────────── HISTORY ─────────────

  void _loadHistory() {
    logs.addAll([
      VitalsLog(
        dateTime: DateTime.now().copyWith(hour: 8, minute: 10),
        title: "Vitals Log 1",
        recordedBy: "Priya Nair",
      ),
      VitalsLog(
        dateTime: DateTime.now().copyWith(hour: 12, minute: 35),
        title: "Vitals Log 2",
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

  String formatTime(DateTime dateTime) => DateFormat("h:mm a").format(dateTime);

  /// ───────────── NAVIGATION ─────────────

  void openVitalsDetail(VitalsLog log) {
    selectedLog = log;
    _loadDetails();

    navigationService.pushNamed(
      Routes.csVitalsDetails,
    );
  }

  /// ───────────── DETAIL DATA ─────────────

  void _loadDetails() {
    sections
      ..clear()
      ..addAll(_dummySections);

    ref.notifyListeners();
  }

  bool get isToday {
    if (selectedLog == null) return false;
    final now = DateTime.now();
    final d = selectedLog!.dateTime;
    return now.year == d.year && now.month == d.month && now.day == d.day;
  }
}

/// ───────────── DUMMY DETAIL DATA ─────────────

final _dummySections = [
  // 1. BLOOD PRESSURE
  VitalSection(
    title: "Blood Pressure",
    icon: Icons.water_drop_outlined,
    values: [
      VitalValue(
          label: "Lying",
          value: "98",
          unit: "mmHg",
          status: VitalStatus.normal),
      VitalValue(
          label: "Sitting",
          value: "98",
          unit: "mmHg",
          status: VitalStatus.hypotension),
      VitalValue(
          label: "Standing",
          value: "101",
          unit: "mmHg",
          status: VitalStatus.hypotension),
    ],
  ),

  // 2. HEART & RESPIRATORY
  VitalSection(
    title: "Heart & Respiratory",
    icon: Icons.monitor_heart_outlined,
    values: [
      VitalValue(
          label: "Pulse",
          value: "98",
          unit: "mmHg",
          status: VitalStatus.normal),
      VitalValue(
          label: "SPO₂", value: "98", unit: "%", status: VitalStatus.normal),
      VitalValue(
          label: "Temperature",
          value: "98.6",
          unit: "°F",
          status: VitalStatus.normal),
      VitalValue(
          label: "Temperature",
          value: "98.6",
          unit: "°F",
          status: VitalStatus.normal),
    ],
  ),

  // 3. MEASUREMENTS
  VitalSection(
    title: "Measurements",
    icon: Icons.straighten,
    values: [
      VitalValue(
        label: "Blood Sugar",
        value: "143",
        unit: "mg/dl",
        status: VitalStatus.nonDiabetic,
        fullWidth: true,
      ),
    ],
  ),

  // 4. OUTPUT & SCORE
  VitalSection(
    title: "Output & Score",
    icon: Icons.water_drop_outlined,
    values: [
      VitalValue(
        label: "Pain Score",
        value: "5/10",
        unit: "",
        status: VitalStatus.mild,
        fullWidth: true,
      ),
      VitalValue(
        label: "Urine Output",
        value: "5",
        unit: "",
        status: VitalStatus.moderate,
      ),
      VitalValue(
        label: "Stool Output",
        value: "2",
        unit: "/day",
        status: VitalStatus.normal,
      ),
    ],
  ),
];
