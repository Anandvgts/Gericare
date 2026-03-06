import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'care_plan_controller.g.dart';


class CarePlanLog {
  final DateTime dateTime;
  final String title;
  final String recordedBy;

  CarePlanLog({
    required this.dateTime,
    required this.title,
    required this.recordedBy,
  });
}

class CarePlanStatusItem {
  final String label;
  final bool isDone;

  CarePlanStatusItem({
    required this.label,
    required this.isDone,
  });
}

/// ───────────── CONTROLLER ─────────────

@riverpod
class CarePlanController extends _$CarePlanController {
  // late final String patientId;

  /// Screen state
  DateTime selectedDate = DateTime.now();

  /// Data
  final List<CarePlanLog> logs = [];
  final List<CarePlanStatusItem> statusItems = [];

  @override
  AsyncValue<void> build(String patientId) {
    // this.patientId = patientId;
    _loadData();
    return const AsyncValue.data(null);
  }

  void _loadData() {
    logs
      ..clear()
      ..addAll([
        CarePlanLog(
          dateTime: DateTime.now().copyWith(hour: 8, minute: 10),
          title: "Care Plan Log 1",
          recordedBy: "Priya Nair",
        ),
        CarePlanLog(
          dateTime: DateTime.now().copyWith(hour: 12, minute: 35),
          title: "Care Plan Log 2",
          recordedBy: "Vinay Kumar",
        ),
      ]);

    statusItems
      ..clear()
      ..addAll([
        CarePlanStatusItem(label: "Slept Well", isDone: true),
        CarePlanStatusItem(label: "Perineal Care", isDone: true),
        CarePlanStatusItem(label: "Skin Care", isDone: true),
        CarePlanStatusItem(label: "Feeding", isDone: false),
        CarePlanStatusItem(label: "Motion Passed", isDone: false),
        CarePlanStatusItem(label: "Medicines Given", isDone: true),
      ]);

    ref.notifyListeners();
  }

  void onDateSelected(DateTime date) {
    selectedDate = date;
    ref.notifyListeners();
  }

  String get formattedDate => DateFormat("EEEE, d MMM").format(selectedDate);
}
