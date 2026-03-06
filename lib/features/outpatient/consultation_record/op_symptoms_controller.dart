import 'package:doctor/features/outpatient/consultation_record/op_symptoms_view.dart';
import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_symptoms_controller.g.dart';

class SymptomItem {
  final String name;
  String? since;
  String? severity;

  SymptomItem({
    required this.name,
    this.since,
    this.severity,
  });

  bool get isComplete => since != null && severity != null;

  Map<String, dynamic> toJson() => {
        'name': name,
        'since': since,
        'severity': severity,
      };
}

@riverpod
class OpSymptomsController extends _$OpSymptomsController {
  final TextEditingController searchController = TextEditingController();

  final List<SymptomItem> _selectedSymptoms = [];
  List<SymptomItem> get selectedSymptoms => _selectedSymptoms;

  // Dummy data for symptoms master list
  final List<String> _allSymptoms = [
    'Headache',
    'Fever',
    'Cough',
    'Cold',
    'Body Pain',
    'Fatigue',
    'Nausea',
    'Vomiting',
    'Diarrhea',
    'Chest Pain',
    'Shortness of Breath',
    'Dizziness',
    'Back Pain',
    'Joint Pain',
    'Abdominal Pain',
    'Loss of Appetite',
    'Insomnia',
    'Anxiety',
    'Depression',
    'Skin Rash',
    'Sore Throat',
    'Runny Nose',
    'Ear Pain',
    'Eye Pain',
    'Muscle Weakness',
    'Numbness',
    'Swelling',
    'Weight Loss',
    'Weight Gain',
    'Palpitations',
  ];

  String _consultationId = '';

  String get searchText => searchController.text.trim();

  List<String> get filteredSymptoms {
    final query = searchText.toLowerCase();
    if (query.isEmpty) return _allSymptoms;
    return _allSymptoms.where((s) => s.toLowerCase().contains(query)).toList();
  }

  bool get canCreate {
    final query = searchText;
    if (query.isEmpty) return false;
    return !_allSymptoms.any((s) => s.toLowerCase() == query.toLowerCase());
  }

  bool get canSave => _selectedSymptoms.isNotEmpty && _selectedSymptoms.every((s) => s.isComplete);

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    _loadDummyData();
    return const AsyncValue.data(null);
  }

  void _loadDummyData() {
    // Load some pre-selected symptoms for demo
    _selectedSymptoms.clear();
    _selectedSymptoms.addAll([
      SymptomItem(name: 'Tongue gets dry - long term, now getting worse', since: '1 week', severity: 'Moderate'),
      SymptomItem(name: 'Throat - dry, burning', since: '3 days', severity: 'Mild'),
    ]);
  }

  void onSearchChanged() {
    ref.notifyListeners();
  }

  void toggleSymptom(BuildContext context, String name) {
    final existing = _selectedSymptoms.where((s) => s.name == name).firstOrNull;
    if (existing != null) {
      _selectedSymptoms.remove(existing);
    } else {
      final symptom = SymptomItem(name: name);
      _selectedSymptoms.add(symptom);
      openSymptomDetail(context, name, existing: symptom);
    }
    ref.notifyListeners();
  }

  void removeSymptom(SymptomItem symptom) {
    _selectedSymptoms.remove(symptom);
    ref.notifyListeners();
  }

  void createSymptom(BuildContext context) {
    final name = searchText;
    _allSymptoms.add(name);
    toggleSymptom(context, name);
    searchController.clear();
  }

  void openSymptomDetail(BuildContext context, String name, {SymptomItem? existing}) {
    final symptom = existing ?? SymptomItem(name: name);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SymptomDetailsBottomSheet(
        symptom: symptom,
        onSave: (updated) {
          final index = _selectedSymptoms.indexWhere((s) => s.name == updated.name);
          if (index >= 0) {
            _selectedSymptoms[index] = updated;
          } else {
            _selectedSymptoms.add(updated);
          }
          ref.notifyListeners();
        },
      ),
    );
  }

  void onSaveSymptoms() {
    // TODO: Save symptoms to API when ready
    debugPrint('Saving symptoms: ${_selectedSymptoms.map((s) => '${s.name} (${s.since}, ${s.severity})').toList()}');
    navigationService.pop();
  }
}
