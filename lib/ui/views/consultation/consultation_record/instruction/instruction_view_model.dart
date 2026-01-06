import 'package:flutter/material.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';

class InstructionItem {
  final String text;
  bool selected;

  InstructionItem({
    required this.text,
    this.selected = false,
  });
}


class InstructionsViewModel extends VGTSBaseViewModel {

  final TextEditingController searchController = TextEditingController();
  final List<InstructionItem> instructions = [
    InstructionItem(text: "Plenty of fluids"),
    InstructionItem(text: "Steam Inhalation"),
    InstructionItem(text: "Gargle with warm water"),
    InstructionItem(text: "Walk regularly for 30 minutes daily"),
    InstructionItem(text: "Luke warm water to drink"),
    InstructionItem(text: "Continue Rest"),
    InstructionItem(
      text:
          "Soft – Bland diet: Khichri, suji kheer, banana mash, daliya, rice dal, custard, oats, melted ice-cream, bread & milk",
    ),
    InstructionItem(
      text:
          "Avoid chilly, spicy, fat food, junk food, food containing preservatives, tea, coffee, cold drinks",
    ),
    InstructionItem(text: "Low Salt in diet"),
    InstructionItem(text: "Low fat in diet"),
    InstructionItem(text: "Avoid oily/fried food"),
  ];

  String search = "";

  List<InstructionItem> get filtered {
    if (search.isEmpty) return instructions;

    return instructions
        .where((e) =>
            e.text.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  bool get canCreate =>
      search.isNotEmpty &&
      !instructions.any(
        (e) => e.text.toLowerCase() == search.toLowerCase(),
      );

  int get selectedCount =>
      instructions.where((e) => e.selected).length;

  void toggle(InstructionItem item) {
    item.selected = !item.selected;
    notifyListeners();
  }

  void createAndSelect() {
    final item = InstructionItem(text: search, selected: true);
    instructions.insert(0, item);
    search = "";
    notifyListeners();
  }
}
