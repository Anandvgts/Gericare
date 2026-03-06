import 'package:doctor/features/outpatient/consultation_record/op_findings_view.dart';
import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_findings_controller.g.dart';

class FindingItem {
  final String name;
  String? notes;
  String? duration;
  String? severity;

  FindingItem({required this.name, this.notes, this.duration, this.severity});

  bool get isComplete => duration != null && severity != null;

  Map<String, dynamic> toJson() => {
        'name': name,
        'notes': notes,
        'duration': duration,
        'severity': severity,
      };
}

@riverpod
class OpFindingsController extends _$OpFindingsController {
  final TextEditingController searchController = TextEditingController();

  final List<FindingItem> _selectedFindings = [];
  List<FindingItem> get selectedFindings => _selectedFindings;

  // Dummy data for findings master list
  final List<String> _allFindings = [
    'Pallor',
    'Icterus',
    'Cyanosis',
    'Clubbing',
    'Edema',
    'Lymphadenopathy',
    'Dehydration',
    'Tachycardia',
    'Bradycardia',
    'Murmur',
    'Crepitations',
    'Rhonchi',
    'Wheezing',
    'Hepatomegaly',
    'Splenomegaly',
    'Tenderness',
    'Rigidity',
    'Guarding',
    'Distension',
    'Swelling',
    'Thin, Kyphosis (+)',
    'Reduced mobility',
    'Joint stiffness',
  ];

  String _consultationId = '';

  String get searchText => searchController.text.trim();

  List<String> get filteredFindings {
    final query = searchText.toLowerCase();
    if (query.isEmpty) return _allFindings;
    return _allFindings.where((f) => f.toLowerCase().contains(query)).toList();
  }

  bool get canCreate {
    final query = searchText;
    if (query.isEmpty) return false;
    return !_allFindings.any((f) => f.toLowerCase() == query.toLowerCase());
  }

  bool get canSave => _selectedFindings.isNotEmpty && _selectedFindings.every((f) => f.isComplete);

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    _loadDummyData();
    return const AsyncValue.data(null);
  }

  void _loadDummyData() {
    // Load some pre-selected findings for demo
    _selectedFindings.clear();
    _selectedFindings.addAll([
      FindingItem(name: 'Thin, Kyphosis (+)', duration: '1 week', severity: 'Moderate'),
    ]);
  }

  void onSearchChanged() => ref.notifyListeners();

  void toggleFinding(BuildContext context, String name) {
    final existing = _selectedFindings.where((f) => f.name == name).firstOrNull;
    if (existing != null) {
      _selectedFindings.remove(existing);
    } else {
      final finding = FindingItem(name: name);
      _selectedFindings.add(finding);
      openFindingDetail(context, name, existing: finding);
    }
    ref.notifyListeners();
  }

  void removeFinding(FindingItem finding) {
    _selectedFindings.remove(finding);
    ref.notifyListeners();
  }

  void createFinding(BuildContext context) {
    final name = searchText;
    _allFindings.add(name);
    toggleFinding(context, name);
    searchController.clear();
  }

  void openFindingDetail(BuildContext context, String name, {FindingItem? existing}) {
    final finding = existing ?? FindingItem(name: name);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FindingDetailsBottomSheet(
        finding: finding,
        onSave: (updated) {
          final index = _selectedFindings.indexWhere((f) => f.name == updated.name);
          if (index >= 0) {
            _selectedFindings[index] = updated;
          } else {
            _selectedFindings.add(updated);
          }
          ref.notifyListeners();
        },
      ),
    );
  }

  void onSaveFindings() {
    // TODO: Save findings to API when ready
    debugPrint('Saving findings: ${_selectedFindings.map((f) => '${f.name} (${f.severity})').toList()}');
    navigationService.pop();
  }
}
