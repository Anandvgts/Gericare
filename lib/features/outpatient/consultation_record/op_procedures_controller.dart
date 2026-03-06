import 'package:doctor/features/outpatient/consultation_record/op_procedures_view.dart';
import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_procedures_controller.g.dart';

class ProcedureItem {
  final String name;
  String? notes;

  ProcedureItem({required this.name, this.notes});

  Map<String, dynamic> toJson() => {
        'name': name,
        'notes': notes,
      };
}

@riverpod
class OpProceduresController extends _$OpProceduresController {
  final TextEditingController searchController = TextEditingController();

  final List<ProcedureItem> _selectedProcedures = [];
  List<ProcedureItem> get selectedProcedures => _selectedProcedures;

  // Dummy data for procedures master list
  final List<String> _allProcedures = [
    'Wound Dressing',
    'Suture Removal',
    'Catheterization',
    'IV Cannulation',
    'Blood Transfusion',
    'Lumbar Puncture',
    'Pleural Tap',
    'Ascitic Tap',
    'Joint Aspiration',
    'Incision and Drainage',
    'Biopsy',
    'Nebulization',
    'Oxygen Therapy',
    'NG Tube Insertion',
    'Foley Catheter Insertion',
    'ECG Recording',
    'Spirometry',
    'Eye Examination',
  ];

  String _consultationId = '';

  String get searchText => searchController.text.trim();

  List<String> get filteredProcedures {
    final query = searchText.toLowerCase();
    if (query.isEmpty) return _allProcedures;
    return _allProcedures.where((p) => p.toLowerCase().contains(query)).toList();
  }

  bool get canCreate {
    final query = searchText;
    if (query.isEmpty) return false;
    return !_allProcedures.any((p) => p.toLowerCase() == query.toLowerCase());
  }

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    return const AsyncValue.data(null);
  }

  void onSearchChanged() => ref.notifyListeners();

  void toggleProcedure(BuildContext context, String name) {
    final existing = _selectedProcedures.where((p) => p.name == name).firstOrNull;
    if (existing != null) {
      _selectedProcedures.remove(existing);
    } else {
      openProcedureDetail(context, name);
    }
    ref.notifyListeners();
  }

  void removeProcedure(ProcedureItem procedure) {
    _selectedProcedures.remove(procedure);
    ref.notifyListeners();
  }

  void createProcedure(BuildContext context) {
    final name = searchText;
    _allProcedures.add(name);
    openProcedureDetail(context, name);
    searchController.clear();
  }

  void openProcedureDetail(BuildContext context, String name, {ProcedureItem? existing}) {
    final procedure = existing ?? ProcedureItem(name: name);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProcedureDetailsBottomSheet(
        procedure: procedure,
        onSave: (updated) {
          final index = _selectedProcedures.indexWhere((p) => p.name == updated.name);
          if (index >= 0) {
            _selectedProcedures[index] = updated;
          } else {
            _selectedProcedures.add(updated);
          }
          ref.notifyListeners();
        },
      ),
    );
  }

  void onSaveProcedures() {
    // TODO: Save procedures to API when ready
    debugPrint('Saving procedures: ${_selectedProcedures.map((p) => p.name).toList()}');
    navigationService.pop();
  }
}
