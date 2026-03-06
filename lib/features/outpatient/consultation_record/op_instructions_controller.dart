import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_instructions_controller.g.dart';

@riverpod
class OpInstructionsController extends _$OpInstructionsController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController customInstructionController = TextEditingController();

  final List<String> _selectedInstructions = [];
  List<String> get selectedInstructions => _selectedInstructions;

  // Dummy data for instructions master list
  final List<String> _allInstructions = [
    'Take plenty of rest',
    'Drink plenty of water',
    'Avoid spicy food',
    'Avoid oily food',
    'Take medicines after food',
    'Avoid alcohol',
    'Avoid smoking',
    'Exercise daily',
    'Walk for 30 minutes daily',
    'Follow up after 1 week',
    'Follow up after 2 weeks',
    'Monitor blood pressure daily',
    'Monitor blood sugar levels',
    'Avoid stress',
    'Get adequate sleep',
    'Avoid cold drinks',
    'Take warm water',
    'Apply ice pack',
    'Apply hot compress',
    'Elevate the affected limb',
    'Inadequate beta glucan intake (440431000124105)',
    'Adolescent and young adult oncology care (1351996009)',
  ];

  String _consultationId = '';

  String get searchText => searchController.text.trim();

  List<String> get filteredInstructions {
    final query = searchText.toLowerCase();
    if (query.isEmpty) return _allInstructions;
    return _allInstructions.where((i) => i.toLowerCase().contains(query)).toList();
  }

  bool get canCreate {
    final query = searchText;
    if (query.isEmpty) return false;
    return !_allInstructions.any((i) => i.toLowerCase() == query.toLowerCase());
  }

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    _loadDummyData();
    return const AsyncValue.data(null);
  }

  void _loadDummyData() {
    // Load some pre-selected instructions for demo
    _selectedInstructions.clear();
    _selectedInstructions.addAll([
      'Inadequate beta glucan intake (440431000124105)',
      'Adolescent and young adult oncology care (1351996009)',
    ]);
  }

  void onSearchChanged() => ref.notifyListeners();

  void toggleInstruction(String instruction) {
    if (_selectedInstructions.contains(instruction)) {
      _selectedInstructions.remove(instruction);
    } else {
      _selectedInstructions.add(instruction);
    }
    ref.notifyListeners();
  }

  void removeInstruction(String instruction) {
    _selectedInstructions.remove(instruction);
    ref.notifyListeners();
  }

  void createInstruction() {
    final instruction = searchText;
    _allInstructions.add(instruction);
    _selectedInstructions.add(instruction);
    searchController.clear();
    ref.notifyListeners();
  }

  void addCustomInstruction() {
    final instruction = customInstructionController.text.trim();
    if (instruction.isNotEmpty) {
      _selectedInstructions.add(instruction);
      customInstructionController.clear();
      ref.notifyListeners();
    }
  }

  void onSaveInstructions() {
    // TODO: Save instructions to API when ready
    debugPrint('Saving instructions: $_selectedInstructions');
    navigationService.pop();
  }
}
