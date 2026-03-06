import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/findings/findings_view.dart';

class FindingItem {
  final String name;
  String? notes;
  String? duration;
  String? severity;

  FindingItem({
    required this.name,
    this.notes,
    this.duration,
    this.severity,
  });

  bool get isComplete =>
      notes != null &&
      notes!.isNotEmpty &&
      duration != null &&
      severity != null;
}

class FindingsViewModel extends VGTSBaseViewModel {
  final TextEditingController searchCtrl = TextEditingController();

  /// ALL FINDINGS (MASTER)
  final List<String> allFindings = [
    'Afebrile',
    'CNS Examination',
    'Throat pain',
    'S1 S2 Normal',
  ];

  /// SELECTED FINDINGS
  final List<FindingItem> selectedFindings = [];

  String get searchText => searchCtrl.text.trim();

  /// FILTER LIST (REMOVE SELECTED)
  List<String> get filteredFindings {
    final selectedNames = selectedFindings.map((e) => e.name).toSet();

    final source = searchText.isEmpty
        ? allFindings
        : allFindings.where(
            (e) => e.toLowerCase().contains(searchText.toLowerCase()),
          );

    return source.where((e) => !selectedNames.contains(e)).toList();
  }

  /// CREATE NEW FINDING
  bool get canCreate =>
      searchText.isNotEmpty &&
      !allFindings.any(
        (e) => e.toLowerCase() == searchText.toLowerCase(),
      );

  void toggleFinding(BuildContext context, String name) {
    final exists = selectedFindings.any((e) => e.name == name);

    if (exists) {
      selectedFindings.removeWhere((e) => e.name == name);
    } else {
      /// ✅ ONLY ADD — NO BOTTOM SHEET
      selectedFindings.add(
        FindingItem(name: name),
      );
    }

    notifyListeners();
  }

  /// OPEN DETAIL SHEET
  void openFindingDetail(
    BuildContext context,
    String name, {
    FindingItem? existing,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FindingDetailsBottomSheet(
        finding: existing ??
            FindingItem(
              name: name,
              // notes: existing?.notes,
              // duration: existing?.duration,
              // severity: existing?.severity,
            ),
        onSave: (item) {
          final index = selectedFindings.indexWhere((e) => e.name == item.name);

          if (index != -1) {
            selectedFindings[index] = item;
          } else {
            selectedFindings.add(item);
          }
          notifyListeners();
        },
      ),
    );
  }

  /// VALIDATION
  bool get hasIncompleteFindings => selectedFindings.any((e) => !e.isComplete);

  bool get canSaveFindings =>
      selectedFindings.isNotEmpty &&
      selectedFindings.every((e) => e.isComplete);

  void createFinding(BuildContext context) {
    final value = searchText;
    allFindings.add(value);
    selectedFindings.add(FindingItem(name: value));
    searchCtrl.clear();
    notifyListeners();
  }
}
