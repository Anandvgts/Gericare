import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/symptoms/symptoms_view.dart';

class SymptomItem {
  final String name;
  String? since;
  String? description;

  SymptomItem({
    required this.name,
    this.since,
    this.description,
  });

  bool get isComplete =>
      since != null &&
      description != null;
}


class SymptomsViewModel extends VGTSBaseViewModel {
  final TextEditingController searchCtrl = TextEditingController();

  /// ALL SYMPTOMS
  final List<String> allSymptoms = [
    'Fever',
    'Cold',
    'Cough',
    'Bodyache',
    'General Weakness',
    'Throat pain',
  ];

  /// SELECTED
  final List<SymptomItem> selectedSymptoms = [];

  String get searchText => searchCtrl.text.trim();

  List<String> get filteredSymptoms {
    final selectedNames = selectedSymptoms.map((e) => e.name).toSet();

    final source = searchText.isEmpty
        ? allSymptoms
        : allSymptoms.where(
            (e) => e.toLowerCase().contains(searchText.toLowerCase()),
          );

    return source.where((e) => !selectedNames.contains(e)).toList();
  }

  bool get canCreate =>
      searchText.isNotEmpty &&
      !allSymptoms.any(
        (e) => e.toLowerCase() == searchText.toLowerCase(),
      );

  /// ADD / REMOVE (NO SHEET)
  void toggleSymptom(BuildContext context, String name) {
    final exists = selectedSymptoms.any((e) => e.name == name);

    if (exists) {
      selectedSymptoms.removeWhere((e) => e.name == name);
    } else {
      selectedSymptoms.add(SymptomItem(name: name));
    }

    notifyListeners();
  }

  /// OPEN DETAILS (ONLY FROM !)
  void openSymptomDetail(
    BuildContext context,
    String name, {
    SymptomItem? existing,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SymptomDetailsBottomSheet(
        symptom: existing ?? SymptomItem(name: name),
        onSave: (_) => notifyListeners(),
      ),
    );
  }

  bool get canSaveSymptoms =>
      selectedSymptoms.isNotEmpty &&
      selectedSymptoms.every((e) => e.isComplete);
}
