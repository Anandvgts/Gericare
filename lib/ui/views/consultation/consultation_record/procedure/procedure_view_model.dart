import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';

class ProcedureItem {
  final String name;
  bool selected;

  ProcedureItem({
    required this.name,
    this.selected = false,
  });
}



class ProceduresViewModel extends VGTSBaseViewModel {
  final TextEditingController searchController = TextEditingController();

  String search = "";

  final List<ProcedureItem> procedures = [
    ProcedureItem(name: "INSULIN"),
    ProcedureItem(name: "Injection"),
    ProcedureItem(name: "Nebulization"),
    ProcedureItem(name: "IV Fluids"),
    ProcedureItem(name: "Catheterization"),
    ProcedureItem(name: "Wound Dressing"),
    ProcedureItem(name: "Blood Transfusion"),
    ProcedureItem(name: "Physiotherapy"),
    ProcedureItem(name: "Suture Removal"),
    ProcedureItem(name: "ECG"),
  ];

  /// Filtered list
  List<ProcedureItem> get filtered {
    if (search.isEmpty) return procedures;

    return procedures
        .where(
          (e) => e.name.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
  }

  /// Can create new
  bool get canCreate =>
      search.isNotEmpty &&
      !procedures.any(
        (e) => e.name.toLowerCase() == search.toLowerCase(),
      );

  /// Selected count
  int get selectedCount =>
      procedures.where((e) => e.selected).length;

  /// Toggle selection
  void toggle(ProcedureItem item) {
    item.selected = !item.selected;
    notifyListeners();
  }

  /// Create + select
  void createAndSelect() {
    final item = ProcedureItem(name: search, selected: true);
    procedures.insert(0, item);
    search = "";
    searchController.clear();
    notifyListeners();
  }
}
