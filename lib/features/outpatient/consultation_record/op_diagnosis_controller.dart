import 'package:doctor/features/outpatient/consultation_record/op_diagnosis_view.dart';
import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_diagnosis_controller.g.dart';

class DiagnosisItem {
  final String name;
  String? since;
  String? location;
  String? treatmentStatus;

  DiagnosisItem({
    required this.name,
    this.since,
    this.location,
    this.treatmentStatus,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'since': since,
        'location': location,
        'treatment_status': treatmentStatus,
      };
}

@riverpod
class OpDiagnosisController extends _$OpDiagnosisController {
  final TextEditingController searchController = TextEditingController();

  final List<DiagnosisItem> _selectedDiagnosis = [];
  List<DiagnosisItem> get selectedDiagnosis => _selectedDiagnosis;

  // Dummy data for diagnosis master list
  final List<String> _allDiagnosis = [
    'Hypertension',
    'Diabetes Mellitus',
    'Coronary Artery Disease',
    'Chronic Kidney Disease',
    'COPD',
    'Asthma',
    'Arthritis',
    'Osteoporosis',
    'Hypothyroidism',
    'Hyperthyroidism',
    'Anemia',
    'Depression',
    'Anxiety Disorder',
    'Migraine',
    'Epilepsy',
    'Parkinson Disease',
    'Alzheimer Disease',
    'Stroke',
    'Heart Failure',
    'Atrial Fibrillation',
    'Acid reflux disease',
    'B12 deficiency',
    'Gastritis',
    'GERD',
    'IBS',
  ];

  String _consultationId = '';

  String get searchText => searchController.text.trim();

  List<String> get filteredDiagnosis {
    final query = searchText.toLowerCase();
    if (query.isEmpty) return _allDiagnosis;
    return _allDiagnosis.where((d) => d.toLowerCase().contains(query)).toList();
  }

  bool get canCreate {
    final query = searchText;
    if (query.isEmpty) return false;
    return !_allDiagnosis.any((d) => d.toLowerCase() == query.toLowerCase());
  }

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    _loadDummyData();
    return const AsyncValue.data(null);
  }

  void _loadDummyData() {
    // Load some pre-selected diagnosis for demo
    _selectedDiagnosis.clear();
    _selectedDiagnosis.addAll([
      DiagnosisItem(name: 'Acid reflux disease', since: '6-12 Months', treatmentStatus: 'On Treatment'),
      DiagnosisItem(name: 'B12 deficiency', since: '0-3 Months', treatmentStatus: 'On Treatment'),
    ]);
  }

  void onSearchChanged() {
    ref.notifyListeners();
  }

  void toggleDiagnosis(BuildContext context, String name) {
    final existing = _selectedDiagnosis.where((d) => d.name == name).firstOrNull;
    if (existing != null) {
      _selectedDiagnosis.remove(existing);
    } else {
      final diagnosis = DiagnosisItem(name: name);
      _selectedDiagnosis.add(diagnosis);
      openDiagnosisDetail(context, name, existing: diagnosis);
    }
    ref.notifyListeners();
  }

  void removeDiagnosis(DiagnosisItem diagnosis) {
    _selectedDiagnosis.remove(diagnosis);
    ref.notifyListeners();
  }

  void createDiagnosis(BuildContext context) {
    final name = searchText;
    _allDiagnosis.add(name);
    toggleDiagnosis(context, name);
    searchController.clear();
  }

  void openDiagnosisDetail(BuildContext context, String name, {DiagnosisItem? existing}) {
    final diagnosis = existing ?? DiagnosisItem(name: name);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DiagnosisDetailsBottomSheet(
        diagnosis: diagnosis,
        onSave: (updated) {
          final index = _selectedDiagnosis.indexWhere((d) => d.name == updated.name);
          if (index >= 0) {
            _selectedDiagnosis[index] = updated;
          } else {
            _selectedDiagnosis.add(updated);
          }
          ref.notifyListeners();
        },
      ),
    );
  }

  void onSaveDiagnosis() {
    // TODO: Save diagnosis to API when ready
    debugPrint('Saving diagnosis: ${_selectedDiagnosis.map((d) => '${d.name} (${d.since}, ${d.treatmentStatus})').toList()}');
    navigationService.pop();
  }
}
