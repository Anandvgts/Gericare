import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/medicine/medicine_view.dart';

class MedicineItem {
  final String name;
  final String dosageSummary; // shown under selected chip

  MedicineItem({
    required this.name,
    this.dosageSummary = '',
  });

  MedicineItem copyWith({
    String? dosageSummary,
  }) {
    return MedicineItem(
      name: name,
      dosageSummary: dosageSummary ?? this.dosageSummary,
    );
  }
}

class MedicinesViewModel extends VGTSBaseViewModel {
  final TextEditingController searchCtrl = TextEditingController();

  final List<String> allMedicines = [
    "Dolo (650 mg)",
    "Azithral (500 mg)",
    "Veloz D",
    "Razo D",
    "Paracip (500 mg)",
    "Cepodem (200 mg)",
    "Cefixime (200 mg)",
  ];

  final List<MedicineItem> selectedMedicines = [];

  String get searchText => searchCtrl.text.trim();

  List<String> get filteredMedicines {
    final selectedNames = selectedMedicines.map((e) => e.name).toSet();

    final source = searchText.isEmpty
        ? allMedicines
        : allMedicines.where(
            (e) => e.toLowerCase().contains(searchText.toLowerCase()),
          );

    return source.where((e) => !selectedNames.contains(e)).toList();
  }

  bool get canCreate =>
      searchText.isNotEmpty &&
      !allMedicines.any(
        (e) => e.toLowerCase() == searchText.toLowerCase(),
      );

  /// Open FULL SCREEN dosage page
  void openMedicineDetail(BuildContext context, String name) async {
    final result = await Navigator.push<MedicineItem>(
      context,
      MaterialPageRoute(
        builder: (_) => MedicineDosageView(medicineName: name),
      ),
    );

    if (result != null) {
      selectedMedicines.removeWhere((e) => e.name == result.name);
      selectedMedicines.add(result);
      notifyListeners();
    }
  }

  void removeMedicine(String name) {
    selectedMedicines.removeWhere((e) => e.name == name);
    notifyListeners();
  }

  void createMedicine(BuildContext context) {
    final value = searchText;
    allMedicines.add(value);
    searchCtrl.clear();
    notifyListeners();
    openMedicineDetail(context, value);
  }
}

enum MedicineType { tablet, syrup }

enum TimingMode { frequency, dayParts }

class MedicineDosageViewModel extends VGTSBaseViewModel {
  /// ---------------- Quantity ----------------
  /// 
  


  MedicineType type = MedicineType.tablet;
  double quantity = 0.5;

  List<double> get quantityOptions {
    if (type == MedicineType.tablet) {
      return [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4];
    } else {
      return [1, 1.5, 2, 2.5, 3];
    }
  }

  void setType(MedicineType value) {
    type = value;
    quantity = quantityOptions.first;
    notifyListeners();
  }

  void setQuantity(double v) {
    quantity = v;
    notifyListeners();
  }

  /// ---------------- Timing ----------------
  TimingMode timingMode = TimingMode.frequency;

  String frequencyUnit = "Hour"; // Hour / Day / Week / Month
  String frequencyValue = "4h";

  void toggleTimingMode() {
    timingMode = timingMode == TimingMode.frequency
        ? TimingMode.dayParts
        : TimingMode.frequency;
    notifyListeners();
  }

  /// ---------------- Intake ----------------
  String intake = "After Food";

  void setIntake(String v) {
    intake = v;
    notifyListeners();
  }

  /// ---------------- Day Parts ----------------
  double morningQty = 1.0;
  double noonQty = 1.0;
  double nightQty = 1.0;

 double _step(double value, int delta) {
  final updated = value + (delta * 0.5);
  return updated.clamp(0.5, 10.0);
}

void updateDayQty(String part, int delta) {
  switch (part) {
    case 'morning':
      morningQty = _step(morningQty, delta);
      break;
    case 'noon':
      noonQty = _step(noonQty, delta);
      break;
    case 'night':
      nightQty = _step(nightQty, delta);
      break;
  }
  notifyListeners();
}


String morningIntake = "Before Meal";
String noonIntake = "Before Meal";
String nightIntake = "After Meal";


void updateIntake(String part, String value) {
  switch (part) {
    case "morning":
      morningIntake = value;
      break;
    case "noon":
      noonIntake = value;
      break;
    case "night":
      nightIntake = value;
      break;
  }
  notifyListeners();
}

void openIntakeSheet(BuildContext context, String part) {
  const options = [
    "Before Meal",
    "After Meal",
    "Empty Stomach",
    "Bed Time",
  ];

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => ListView(
      shrinkWrap: true,
      children: options.map((e) {
        return ListTile(
          title: Text(e),
          onTap: () {
            updateIntake(part, e);
            Navigator.pop(context);
          },
        );
      }).toList(),
    ),
  );
}



  /// ---------------- Duration ----------------
  String duration = "1 Day";

  void setDuration(String v) {
    duration = v;
    notifyListeners();
  }

  /// ---------------- Notes ----------------
  String notes = "";
}
