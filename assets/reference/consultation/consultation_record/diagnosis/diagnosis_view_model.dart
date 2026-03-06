import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/diagnosis/diagnosis_view.dart';

class DiagnosisItem {
  final String name;
  final String since;
  final String location;
  final String option;

  DiagnosisItem({
    required this.name,
    this.since = '',
    this.location = '',
    this.option = '',
  });

  DiagnosisItem copyWith({
    String? since,
    String? location,
    String? option,
  }) {
    return DiagnosisItem(
      name: name,
      since: since ?? this.since,
      location: location ?? this.location,
      option: option ?? this.option,
    );
  }
}


class DiagnosisViewModel extends VGTSBaseViewModel {
  final TextEditingController searchCtrl = TextEditingController();

  final List<String> allDiagnosis = [
    "COVID-19",
    "HT-Hypertension",
    "Bronchitis",
    "Pharyngitis",
    "Allergic Rhinitis",
  ];

  final List<DiagnosisItem> selectedDiagnosis = [];

  String get searchText => searchCtrl.text.trim();

List<String> get filteredDiagnosis {
  final selectedNames = selectedDiagnosis.map((e) => e.name).toSet();

  final source = searchText.isEmpty
      ? allDiagnosis
      : allDiagnosis.where(
          (e) => e.toLowerCase().contains(searchText.toLowerCase()),
        );

  return source.where((e) => !selectedNames.contains(e)).toList();
}


  bool get canCreate =>
      searchText.isNotEmpty &&
      !allDiagnosis.any(
        (e) => e.toLowerCase() == searchText.toLowerCase(),
      );

  void toggleDiagnosis(BuildContext context, String name) {
    final exists = selectedDiagnosis.any((e) => e.name == name);

    if (exists) {
      selectedDiagnosis.removeWhere((e) => e.name == name);
      notifyListeners();
    } else {
      openDiagnosisDetail(context, name);
    }
  }

  void openDiagnosisDetail(BuildContext context, String name,
      {DiagnosisItem? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DiagnosisDetailSheet(
        title: name,
        existing: existing,
        onSave: (item) {
          selectedDiagnosis.removeWhere((e) => e.name == item.name);
          selectedDiagnosis.add(item);
          notifyListeners();
        },
      ),
    );
  }

  void createDiagnosis(BuildContext context) {
    final value = searchText;
    allDiagnosis.add(value);
    searchCtrl.clear();
    notifyListeners();
    openDiagnosisDetail(context, value);
  }
}
