import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/medical_history/medical_history_view.dart';

class MedicalProblem {
  final String name;
  final String duration;
  final String medicine;

  MedicalProblem({
    required this.name,
    required this.duration,
    required this.medicine,
  });
}

class FamilyHistoryItem {
  final String illness;
  final List<String> members;

  FamilyHistoryItem({
    required this.illness,
    required this.members,
  });
}

class LifestyleItem {
  final String type; // Smoking, Drinking...
  final String status; // Yes / No / Quit / Occasional
  final String since;
  final String quantity;
  final String unit;

  LifestyleItem({
    required this.type,
    required this.status,
    required this.since,
    required this.quantity,
    required this.unit,
  });
}

class ProcedureItem {
  final String name;
  final String duration;

  ProcedureItem({
    required this.name,
    required this.duration,
  });
}

class MedicalHistoryViewModel extends VGTSBaseViewModel {
  /// Notes per section
  final Map<String, String> sectionNotes = {};

  /// Medical problems
  final List<MedicalProblem> selectedProblems = [
    MedicalProblem(
      name: "Hypertension",
      duration: "0–3 Months",
      medicine: "G2K (400 mg)",
    ),
    MedicalProblem(
      name: "Hypothyroidism",
      duration: "3–6 Months",
      medicine: "",
    ),
  ];

  final List<String> availableProblems = [
    "Fever",
    "CDK",
    "High BP",
  ];

  void openAddNotes(BuildContext context, String sectionTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddNotesBottomSheet(
        title: "$sectionTitle – Notes",
        initialText: sectionNotes[sectionTitle] ?? "",
        onSave: (text) {
          sectionNotes[sectionTitle] = text;
          notifyListeners();
        },
      ),
    );
  }

  /// Called from AddMoreBottomSheet
  void updateMedicalProblems(List<String> labels) {
    selectedProblems
      ..clear()
      ..addAll(
        labels.map(
          (e) => MedicalProblem(
            name: e,
            duration: "",
            medicine: "",
          ),
        ),
      );

    notifyListeners();
  }

  void removeProblem(String name) {
    selectedProblems.removeWhere((e) => e.name == name);
    notifyListeners();
  }

  void openAddMoreProblems(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMoreBottomSheet(
        availableItems: availableProblems,
        selectedItems: selectedProblems.map((e) => e.name).toList(),
        onDone: (items) {
          updateMedicalProblems(items);
        },
      ),
    );
  }

  void openProblemDetail(BuildContext context, MedicalProblem problem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MedicalProblemDetailSheet(
        title: problem.name,
        existing:
            selectedProblems.where((e) => e.name == problem.name).firstOrNull,
        onSave: (updated) {
          selectedProblems.removeWhere((e) => e.name == updated.name);
          selectedProblems.add(updated);
          notifyListeners();
        },
      ),
    );
  }

  //Allergy Section
  bool hasAllergy = false;

  /// OPTIONS (THIS WAS MISSING)
  List<String> generalAllergyOptions = [
    "Banana",
    "Peanuts",
    "Fish",
    "Egg",
  ];

  List<String> drugAllergyOptions = [
    "Sulfa Drugs",
    "Amoxilin",
    "Not Known",
  ];

  List<String> generalAllergies = [];
  List<String> drugAllergies = [];

  void setHasAllergy(bool value) {
    hasAllergy = value;

    if (!value) {
      generalAllergies.clear();
      drugAllergies.clear();
    }

    notifyListeners();
  }

  void updateAllergies({
    required List<String> general,
    required List<String> drug,
    required List<String> generalOptions,
    required List<String> drugOptions,
  }) {
    generalAllergies = general;
    drugAllergies = drug;
    generalAllergyOptions = generalOptions;
    drugAllergyOptions = drugOptions;
    notifyListeners();
  }

  void openAllergiesSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AllergiesBottomSheet(
        general: generalAllergies,
        drug: drugAllergies,
        generalOptions: generalAllergyOptions,
        drugOptions: drugAllergyOptions,
        onSave: updateAllergies,
      ),
    );
  }

  /// ---------- FAMILY HISTORY ----------
  final List<String> familyIllnessOptions = [
    "Hypertension",
    "Fever",
    "CDK",
    "High BP",
  ];

  final List<String> familyMembersOptions = [
    "Sister",
    "Brother",
    "Mother",
    "Father",
  ];

  final List<FamilyHistoryItem> familyHistory = [];

  /// Open bottom sheet
  void openFamilyHistorySheet(
    BuildContext context,
    String illness,
  ) {
    final existing =
        familyHistory.where((e) => e.illness == illness).firstOrNull;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FamilyHistoryBottomSheet(
        illness: illness,
        selected: existing?.members ?? [],
        members: familyMembersOptions,
        onDone: (members) {
          familyHistory.removeWhere((e) => e.illness == illness);
          if (members.isNotEmpty) {
            familyHistory.add(
              FamilyHistoryItem(
                illness: illness,
                members: members,
              ),
            );
          }
          notifyListeners();
        },
      ),
    );
  }

  void removeFamilyHistory(String illness) {
    familyHistory.removeWhere((e) => e.illness == illness);
    notifyListeners();
  }

  // ---------- LIFESTYLE ----------
  final List<String> lifestyleOptions = [
    "Smoking",
    "Drinking",
    "Drugs",
    "Exercise",
    "Sleep Pattern",
  ];

  final Map<String, String> lifestyleUnits = {
    "Smoking": "unit/day",
    "Drinking": "ml/week",
    "Drugs": "times/week",
    "Exercise": "hours/week",
    "Sleep Pattern": "hours/day",
  };

  final List<LifestyleItem> lifestyle = [];

  void openLifestyleDetail(
    BuildContext context,
    String type,
  ) {
    final existing = lifestyle.where((e) => e.type == type).firstOrNull;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LifestyleDetailBottomSheet(
        title: type,
        unit: lifestyleUnits[type]!,
        existing: existing,
        onSave: (item) {
          lifestyle.removeWhere((e) => e.type == item.type);
          lifestyle.add(item);
          notifyListeners();
        },
      ),
    );
  }

  void removeLifestyle(String type) {
    lifestyle.removeWhere((e) => e.type == type);
    notifyListeners();
  }

// ---------- PROCEDURE ----------
  bool? hasProcedure; // null = not selected

  final List<String> availableProcedures = [
    "Appendectomy",
    "Hysterectomy",
    "Cholecystectomy",
  ];

  final List<ProcedureItem> procedures = [];

  void setHasProcedure(bool value, BuildContext context) {
    hasProcedure = value;
    notifyListeners();

    if (value) {
      openProcedureList(context);
    } else {
      procedures.clear();
    }
  }

  void openProcedureList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProcedureListSheet(
        options: availableProcedures,
        selected: procedures,
        vm: this,
      ),
    );
  }

  void openProcedureDuration(BuildContext context, String name,
      {ProcedureItem? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProcedureDurationSheet(
        procedureName: name,
        existing: existing,
        onSave: (item) {
          procedures.removeWhere((e) => e.name == item.name);
          procedures.add(item);
          notifyListeners();
        },
      ),
    );
  }

  // ---------- RISK FACTOR ----------
  List<String> riskFactors = [];
  final List<String> riskOptions = [
    "Iodine deficiency",
    "Over Weight",
    "Lupus",
  ];

  void openRiskFactorSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMoreBottomSheet(
        availableItems: riskOptions,
        selectedItems: riskFactors,
        onDone: (list) {
          riskFactors = list;
          notifyListeners();
        },
      ),
    );
  }
}
