import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:intl/intl.dart';

part 'medications_controller.g.dart';

enum MedicationStatus { taken, refused, skipped }

class MedicationItem {
  final String name;
  final String dose;
  final String subtitle;
  final MedicationStatus status;

  MedicationItem({
    required this.name,
    required this.dose,
    required this.subtitle,
    required this.status,
  });
}

@riverpod
class MedicationsController extends _$MedicationsController {
  DateTime selectedDate = DateTime.now();

  final List<MedicationItem> _morning = [];
  final List<MedicationItem> _afternoon = [];
  final List<MedicationItem> _night = [];

  @override
  AsyncValue<void> build() {
    _loadMedications();
    return const AsyncValue.data(null);
  }

  // ───────────────────────── DATA ─────────────────────────

  void _loadMedications() {
    _morning.addAll([
      MedicationItem(
        name: "Insulin",
        dose: "After Meal",
        subtitle: "",
        status: MedicationStatus.refused,
      ),
      MedicationItem(
        name: "T.PHLOGAM FORTE",
        dose: "1 Tablet",
        subtitle: "Before Meal",
        status: MedicationStatus.taken,
      ),
      MedicationItem(
        name: "T.Shelcal-XT",
        dose: "1 ml",
        subtitle: "",
        status: MedicationStatus.refused,
      ),
      MedicationItem(
        name: "Montek LC (10 & 5)",
        dose: "1 Tablet",
        subtitle: "Every 4 Hours – 1st Time",
        status: MedicationStatus.skipped,
      ),
    ]);

    _afternoon.addAll([
      MedicationItem(
        name: "Bilasure M",
        dose: "1 Tablet",
        subtitle: "Before Meal",
        status: MedicationStatus.taken,
      ),
      MedicationItem(
        name: "Montek LC (10 & 5)",
        dose: "1 Tablet",
        subtitle: "Every 4 Hours – 2nd Time",
        status: MedicationStatus.skipped,
      ),
      MedicationItem(
        name: "Montek LC (10 & 5)",
        dose: "1 Tablet",
        subtitle: "Every 4 Hours – 3rd Time",
        status: MedicationStatus.skipped,
      ),
    ]);

    _night.addAll(
      [
        MedicationItem(
          name: "Bilasure M",
          dose: "1 Tablet",
          subtitle: "Before Meal",
          status: MedicationStatus.taken,
        ),
        MedicationItem(
          name: "T.SHELCAL-XT",
          dose: "1 Tablet",
          subtitle: "Every 4 Hours – 3rd Time",
          status: MedicationStatus.skipped,
        ),
      ],
    );

    ref.notifyListeners();
  }

  // ───────────────────────── GETTERS ─────────────────────────

  String get formattedDate => DateFormat("EEEE, d MMM").format(selectedDate);

  List<MedicationItem> get morning => _morning;
  List<MedicationItem> get afternoon => _afternoon;
  List<MedicationItem> get night => _night;

  // ───────────────────────── ACTIONS ─────────────────────────

  void onDateSelected(DateTime date) {
    selectedDate = date;
    ref.notifyListeners();
  }

  void onAddMedication() {
    // TODO: navigate to add medication
  }

  void onUpdate() {
    // TODO: update medication status
  }
}
