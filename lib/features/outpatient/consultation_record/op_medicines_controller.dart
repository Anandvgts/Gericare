import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_medicines_controller.g.dart';

enum MedicineType { tablet, syrup, injection, capsule }

enum TimingMode { frequency, dayPart }

class MedicineItem {
  final String name;
  MedicineType type;
  double quantity;
  String frequency;
  String intake;
  String duration;
  String? notes;

  // Day part quantities
  double morningQty;
  double noonQty;
  double nightQty;

  MedicineItem({
    required this.name,
    this.type = MedicineType.tablet,
    this.quantity = 1,
    this.frequency = 'Once',
    this.intake = 'After Food',
    this.duration = '1 Week',
    this.notes,
    this.morningQty = 0,
    this.noonQty = 0,
    this.nightQty = 0,
  });

  String get dosageSummary {
    if (morningQty > 0 || noonQty > 0 || nightQty > 0) {
      return '${morningQty.toInt()}-${noonQty.toInt()}-${nightQty.toInt()}';
    }
    return '$frequency, $intake';
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type.name,
        'quantity': quantity,
        'frequency': frequency,
        'intake': intake,
        'duration': duration,
        'notes': notes,
        'morning_qty': morningQty,
        'noon_qty': noonQty,
        'night_qty': nightQty,
      };
}

@riverpod
class OpMedicinesController extends _$OpMedicinesController {
  final TextEditingController searchController = TextEditingController();

  final List<MedicineItem> _selectedMedicines = [];
  List<MedicineItem> get selectedMedicines => _selectedMedicines;

  // Dummy data for medicines master list
  final List<String> _allMedicines = [
    'Paracetamol 500mg',
    'Ibuprofen 400mg',
    'Amoxicillin 500mg',
    'Azithromycin 250mg',
    'Metformin 500mg',
    'Atorvastatin 10mg',
    'Amlodipine 5mg',
    'Omeprazole 20mg',
    'Pantoprazole 40mg',
    'Losartan 50mg',
    'Aspirin 75mg',
    'Clopidogrel 75mg',
    'Metoprolol 25mg',
    'Enalapril 5mg',
    'Furosemide 40mg',
    'Spironolactone 25mg',
    'Insulin Glargine',
    'Glimepiride 2mg',
    'Sitagliptin 100mg',
    'Cetirizine 10mg',
    'Inadequate beta glucan intake',
    'Adolescent and young adult oncology care',
    'Vitamin B12 1000mcg',
    'Vitamin D3 60000IU',
    'Calcium 500mg',
  ];

  String _consultationId = '';

  String get searchText => searchController.text.trim();

  List<String> get filteredMedicines {
    final query = searchText.toLowerCase();
    if (query.isEmpty) return _allMedicines;
    return _allMedicines.where((m) => m.toLowerCase().contains(query)).toList();
  }

  bool get canCreate {
    final query = searchText;
    if (query.isEmpty) return false;
    return !_allMedicines.any((m) => m.toLowerCase() == query.toLowerCase());
  }

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    _loadDummyData();
    return const AsyncValue.data(null);
  }

  void _loadDummyData() {
    // Load some pre-selected medicines for demo
    _selectedMedicines.clear();
    _selectedMedicines.addAll([
      MedicineItem(
        name: 'Vitamin B12 1000mcg',
        type: MedicineType.tablet,
        morningQty: 1,
        noonQty: 0,
        nightQty: 0,
        intake: 'After Food',
        duration: '1 Month',
      ),
      MedicineItem(
        name: 'Pantoprazole 40mg',
        type: MedicineType.tablet,
        morningQty: 1,
        noonQty: 0,
        nightQty: 1,
        intake: 'Before Food',
        duration: '2 Weeks',
      ),
    ]);
  }

  void onSearchChanged() {
    ref.notifyListeners();
  }

  void removeMedicine(MedicineItem medicine) {
    _selectedMedicines.remove(medicine);
    ref.notifyListeners();
  }

  void createMedicine(BuildContext context) {
    final name = searchText;
    _allMedicines.add(name);
    openMedicineDosage(context, name);
    searchController.clear();
  }

  void openMedicineDosage(BuildContext context, String name) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => _OpMedicineDosagePage(medicineName: name),
      ),
    );

    if (result != null) {
      final medicine = MedicineItem(
        name: name,
        type: result['type'] ?? MedicineType.tablet,
        quantity: result['quantity'] ?? 1.0,
        frequency: result['frequency'] ?? 'Once',
        intake: result['intake'] ?? 'After Food',
        duration: result['duration'] ?? '1 Week',
        notes: result['notes'],
        morningQty: result['morningQty'] ?? 0.0,
        noonQty: result['noonQty'] ?? 0.0,
        nightQty: result['nightQty'] ?? 0.0,
      );
      _selectedMedicines.add(medicine);
      ref.notifyListeners();
    }
  }

  void onSaveMedicines() {
    // TODO: Save medicines to API when ready
    debugPrint('Saving medicines: ${_selectedMedicines.map((m) => '${m.name} (${m.dosageSummary})').toList()}');
    navigationService.pop();
  }
}

/// Separate page for medicine dosage (referenced from view)
class _OpMedicineDosagePage extends StatelessWidget {
  final String medicineName;
  const _OpMedicineDosagePage({required this.medicineName});

  @override
  Widget build(BuildContext context) {
    // This redirects to the actual view
    return const SizedBox(); // Placeholder - actual view is in op_medicines_view.dart
  }
}

@riverpod
class OpMedicineDosageController extends _$OpMedicineDosageController {
  MedicineType _type = MedicineType.tablet;
  MedicineType get type => _type;

  double _quantity = 1;
  double get quantity => _quantity;

  TimingMode _timingMode = TimingMode.frequency;
  TimingMode get timingMode => _timingMode;

  String _frequency = 'Once';
  String get frequency => _frequency;

  String _intake = 'After Food';
  String get intake => _intake;

  String _duration = '1 Week';
  String get duration => _duration;

  final TextEditingController notesController = TextEditingController();

  // Day part quantities
  double _morningQty = 0;
  double get morningQty => _morningQty;
  final String _morningIntake = 'After Food';
  String get morningIntake => _morningIntake;

  double _noonQty = 0;
  double get noonQty => _noonQty;
  final String _noonIntake = 'After Food';
  String get noonIntake => _noonIntake;

  double _nightQty = 0;
  double get nightQty => _nightQty;
  final String _nightIntake = 'After Food';
  String get nightIntake => _nightIntake;

  List<double> get quantityOptions => [0.25, 0.5, 1, 1.5, 2, 2.5, 3];

  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  void setType(MedicineType value) {
    _type = value;
    ref.notifyListeners();
  }

  void setQuantity(double value) {
    _quantity = value;
    ref.notifyListeners();
  }

  void toggleTimingMode() {
    _timingMode = _timingMode == TimingMode.frequency ? TimingMode.dayPart : TimingMode.frequency;
    ref.notifyListeners();
  }

  void setFrequency(String value) {
    _frequency = value;
    ref.notifyListeners();
  }

  void setIntake(String value) {
    _intake = value;
    ref.notifyListeners();
  }

  void setDuration(String value) {
    _duration = value;
    ref.notifyListeners();
  }

  void updateDayQty(String part, int delta) {
    switch (part) {
      case 'morning':
        _morningQty = (_morningQty + delta * 0.5).clamp(0, 5);
        break;
      case 'noon':
        _noonQty = (_noonQty + delta * 0.5).clamp(0, 5);
        break;
      case 'night':
        _nightQty = (_nightQty + delta * 0.5).clamp(0, 5);
        break;
    }
    ref.notifyListeners();
  }

  String formatQuantity(double q) {
    if (_type == MedicineType.tablet || _type == MedicineType.capsule) {
      if (q == q.toInt()) return '${q.toInt()} Tab';
      return '$q Tab';
    } else if (_type == MedicineType.syrup) {
      return '${(q * 5).toInt()} ml';
    }
    return q.toString();
  }

  Map<String, dynamic> getMedicineData() {
    return {
      'type': _type,
      'quantity': _quantity,
      'frequency': _frequency,
      'intake': _intake,
      'duration': _duration,
      'notes': notesController.text,
      'morningQty': _morningQty,
      'noonQty': _noonQty,
      'nightQty': _nightQty,
    };
  }
}
