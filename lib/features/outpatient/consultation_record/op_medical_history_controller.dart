import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_medical_history_controller.g.dart';

@riverpod
class OpMedicalHistoryController extends _$OpMedicalHistoryController {
  final TextEditingController notesController = TextEditingController();

  final List<String> _pastMedicalHistory = [];
  List<String> get pastMedicalHistory => _pastMedicalHistory;

  final List<String> _surgicalHistory = [];
  List<String> get surgicalHistory => _surgicalHistory;

  final List<String> _familyHistory = [];
  List<String> get familyHistory => _familyHistory;

  final List<String> _allergies = [];
  List<String> get allergies => _allergies;

  String? _smokingStatus;
  String? get smokingStatus => _smokingStatus;

  String? _alcoholStatus;
  String? get alcoholStatus => _alcoholStatus;

  String? _exerciseStatus;
  String? get exerciseStatus => _exerciseStatus;

  // Uploaded document pages
  final List<String> _uploadedPages = [];
  List<String> get uploadedPages => _uploadedPages;

  String _patientId = '';

  final List<String> allPastMedicalConditions = [
    'Hypertension',
    'Diabetes Mellitus',
    'Coronary Artery Disease',
    'Heart Failure',
    'COPD',
    'Asthma',
    'Chronic Kidney Disease',
    'Liver Disease',
    'Stroke',
    'Epilepsy',
    'Parkinson Disease',
    'Alzheimer Disease',
    'Thyroid Disorder',
    'Cancer',
    'Arthritis',
    'Osteoporosis',
    'Depression',
    'Anxiety',
  ];

  final List<String> allSurgeries = [
    'Appendectomy',
    'Cholecystectomy',
    'Hernia Repair',
    'Cesarean Section',
    'Hysterectomy',
    'CABG',
    'Angioplasty',
    'Joint Replacement',
    'Cataract Surgery',
    'Thyroidectomy',
    'Mastectomy',
    'Prostatectomy',
    'Spinal Surgery',
  ];

  final List<String> allFamilyConditions = [
    'Diabetes',
    'Hypertension',
    'Heart Disease',
    'Cancer',
    'Stroke',
    'Kidney Disease',
    'Thyroid Disorder',
    'Asthma',
    'Depression',
  ];

  final List<String> allAllergies = [
    'Penicillin',
    'Sulfa Drugs',
    'Aspirin',
    'NSAIDs',
    'Iodine',
    'Latex',
    'Peanuts',
    'Shellfish',
    'Eggs',
    'Milk',
    'Dust',
    'Pollen',
  ];

  @override
  AsyncValue<void> build(String patientId) {
    _patientId = patientId;
    _loadDummyData();
    return const AsyncValue.data(null);
  }

  void _loadDummyData() {
    // Load some pre-filled data for demo
    _uploadedPages.clear();
    _uploadedPages.add('page-1'); // Dummy page
  }

  void addPastMedicalHistory(String item) {
    if (!_pastMedicalHistory.contains(item)) {
      _pastMedicalHistory.add(item);
      ref.notifyListeners();
    }
  }

  void removePastMedicalHistory(String item) {
    _pastMedicalHistory.remove(item);
    ref.notifyListeners();
  }

  void addSurgicalHistory(String item) {
    if (!_surgicalHistory.contains(item)) {
      _surgicalHistory.add(item);
      ref.notifyListeners();
    }
  }

  void removeSurgicalHistory(String item) {
    _surgicalHistory.remove(item);
    ref.notifyListeners();
  }

  void addFamilyHistory(String item) {
    if (!_familyHistory.contains(item)) {
      _familyHistory.add(item);
      ref.notifyListeners();
    }
  }

  void removeFamilyHistory(String item) {
    _familyHistory.remove(item);
    ref.notifyListeners();
  }

  void addAllergy(String item) {
    if (!_allergies.contains(item)) {
      _allergies.add(item);
      ref.notifyListeners();
    }
  }

  void removeAllergy(String item) {
    _allergies.remove(item);
    ref.notifyListeners();
  }

  void setSmokingStatus(String status) {
    _smokingStatus = status;
    ref.notifyListeners();
  }

  void setAlcoholStatus(String status) {
    _alcoholStatus = status;
    ref.notifyListeners();
  }

  void setExerciseStatus(String status) {
    _exerciseStatus = status;
    ref.notifyListeners();
  }

  void addPage() {
    _uploadedPages.add('page-${_uploadedPages.length + 1}');
    ref.notifyListeners();
  }

  void removePage(int index) {
    if (index >= 0 && index < _uploadedPages.length) {
      _uploadedPages.removeAt(index);
      ref.notifyListeners();
    }
  }

  void onUpload() {
    // TODO: Implement file picker and upload
    debugPrint('Upload medical history documents');
  }

  void onSaveMedicalHistory() {
    // TODO: Save medical history to API when ready
    debugPrint('Saving medical history:');
    debugPrint('Past Medical: $_pastMedicalHistory');
    debugPrint('Surgical: $_surgicalHistory');
    debugPrint('Family: $_familyHistory');
    debugPrint('Allergies: $_allergies');
    debugPrint('Smoking: $_smokingStatus, Alcohol: $_alcoholStatus, Exercise: $_exerciseStatus');
    navigationService.pop();
  }
}
