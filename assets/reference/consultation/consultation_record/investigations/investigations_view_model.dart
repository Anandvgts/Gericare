import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/investigations/investigations_view.dart';

class InvestigationItem {
  final String name;
  bool selected;

  InvestigationItem({
    required this.name,
    this.selected = false,
  });
}

class InvestigationsViewModel extends VGTSBaseViewModel {
  final TextEditingController searchController = TextEditingController();
  final List<InvestigationItem> investigations = [
    InvestigationItem(name: "Widal Test"),
    InvestigationItem(name: "CBC - Complete Blood Count Haemogram"),
    InvestigationItem(name: "CBC - Complete Blood Count"),
    InvestigationItem(name: "CRP"),
    InvestigationItem(name: "Urine Routine"),
    InvestigationItem(name: "Dengue Fever NS1"),
    InvestigationItem(name: "Urine Routine Microscopic (R/M)"),
    InvestigationItem(name: "RBS (Random Blood Sugar)"),
    InvestigationItem(name: "Malaria Parasite"),
    InvestigationItem(name: "Covid-19"),
    InvestigationItem(name: "X Ray Chest"),
    InvestigationItem(name: "Malaria Antigen"),
    InvestigationItem(name: "Liver Function Test LFT"),
  ];

  String search = "";

  List<InvestigationItem> get filtered {
    if (search.isEmpty) return investigations;
    return investigations
        .where((e) =>
            e.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  int get selectedCount =>
      investigations.where((e) => e.selected).length;

  void toggleItem(InvestigationItem item) {
    item.selected = !item.selected;
    notifyListeners();
  }

  void openDateSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const InvestigationDateSheet(),
    );
  }
}
