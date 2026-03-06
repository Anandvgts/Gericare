import 'package:doctor/features/outpatient/consultation_record/op_investigations_view.dart';
import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_investigations_controller.g.dart';

class InvestigationItem {
  final String name;
  final String? category;
  String? urgency;
  String? notes;

  InvestigationItem({required this.name, this.category, this.urgency = 'Routine', this.notes});

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'urgency': urgency,
        'notes': notes,
      };
}

@riverpod
class OpInvestigationsController extends _$OpInvestigationsController {
  final TextEditingController searchController = TextEditingController();

  final List<InvestigationItem> _selectedInvestigations = [];
  List<InvestigationItem> get selectedInvestigations => _selectedInvestigations;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  final List<String> categories = ['All', 'Blood', 'Urine', 'Imaging', 'Cardiac', 'Other'];

  // Dummy data for investigations by category
  final Map<String, List<String>> _investigationsByCategory = {
    'Blood': ['CBC', 'HbA1c', 'Lipid Profile', 'LFT', 'RFT', 'Thyroid Profile', 'Blood Sugar Fasting', 'Blood Sugar PP', 'ESR', 'CRP', 'Vitamin D', 'Vitamin B12', 'Iron Studies'],
    'Urine': ['Urine Routine', 'Urine Culture', 'Urine Microalbumin', '24hr Urine Protein'],
    'Imaging': ['X-Ray Chest', 'X-Ray Spine', 'USG Abdomen', 'CT Scan Brain', 'CT Scan Chest', 'MRI Brain', 'MRI Spine', 'DEXA Scan'],
    'Cardiac': ['ECG', 'ECHO', 'TMT', 'Holter Monitor', '2D Echo', 'Stress Test'],
    'Other': ['Pulmonary Function Test', 'Nerve Conduction Study', 'EEG', 'EMG', 'Endoscopy', 'Colonoscopy'],
  };

  String _consultationId = '';

  List<String> get _allInvestigations {
    if (_selectedCategory == 'All') {
      return _investigationsByCategory.values.expand((e) => e).toList();
    }
    return _investigationsByCategory[_selectedCategory] ?? [];
  }

  String get searchText => searchController.text.trim();

  List<String> get filteredInvestigations {
    final query = searchText.toLowerCase();
    if (query.isEmpty) return _allInvestigations;
    return _allInvestigations.where((i) => i.toLowerCase().contains(query)).toList();
  }

  bool get canCreate {
    final query = searchText;
    if (query.isEmpty) return false;
    return !_allInvestigations.any((i) => i.toLowerCase() == query.toLowerCase());
  }

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    _loadDummyData();
    return const AsyncValue.data(null);
  }

  void _loadDummyData() {
    // Load some pre-selected investigations for demo
    _selectedInvestigations.clear();
    _selectedInvestigations.addAll([
      InvestigationItem(name: 'CBC', category: 'Blood', urgency: 'Routine'),
      InvestigationItem(name: 'Thyroid Profile', category: 'Blood', urgency: 'Routine'),
    ]);
  }

  void onSearchChanged() => ref.notifyListeners();

  void selectCategory(String category) {
    _selectedCategory = category;
    ref.notifyListeners();
  }

  void toggleInvestigation(BuildContext context, String name) {
    final existing = _selectedInvestigations.where((i) => i.name == name).firstOrNull;
    if (existing != null) {
      _selectedInvestigations.remove(existing);
    } else {
      final investigation = InvestigationItem(name: name, category: _selectedCategory);
      openInvestigationDetail(context, name, existing: investigation);
    }
    ref.notifyListeners();
  }

  void removeInvestigation(InvestigationItem investigation) {
    _selectedInvestigations.remove(investigation);
    ref.notifyListeners();
  }

  void createInvestigation(BuildContext context) {
    final name = searchText;
    _investigationsByCategory['Other']?.add(name);
    openInvestigationDetail(context, name);
    searchController.clear();
  }

  void openInvestigationDetail(BuildContext context, String name, {InvestigationItem? existing}) {
    final investigation = existing ?? InvestigationItem(name: name);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InvestigationDetailsBottomSheet(
        investigation: investigation,
        onSave: (updated) {
          final index = _selectedInvestigations.indexWhere((i) => i.name == updated.name);
          if (index >= 0) {
            _selectedInvestigations[index] = updated;
          } else {
            _selectedInvestigations.add(updated);
          }
          ref.notifyListeners();
        },
      ),
    );
  }

  void onSaveInvestigations() {
    // TODO: Save investigations to API when ready
    debugPrint('Saving investigations: ${_selectedInvestigations.map((i) => '${i.name} (${i.urgency})').toList()}');
    navigationService.pop();
  }
}
