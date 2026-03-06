import 'package:doctor/locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_vitals_controller.g.dart';

@riverpod
class OpVitalsController extends _$OpVitalsController {
  String _consultationId = '';

  /// Pain level (0-10)
  int? _painLevel;
  int? get painLevel => _painLevel;

  /// Blood Pressure controllers
  final TextEditingController bpLyingController = TextEditingController();
  final TextEditingController bpSittingController = TextEditingController();
  final TextEditingController bpStandingController = TextEditingController();

  /// Heart & Respiratory Rate controllers
  final TextEditingController pulseController = TextEditingController();
  final TextEditingController respiratoryRateController = TextEditingController();
  final TextEditingController spo2Controller = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();

  /// Measurements controllers
  final TextEditingController bloodSugarController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    _loadDummyData();
    return const AsyncValue.data(null);
  }

  void _loadDummyData() {
    // Pre-fill some dummy vitals data for demo
    _painLevel = 2;
    bpSittingController.text = '134/82';
    pulseController.text = '74';
    respiratoryRateController.text = '16';
    spo2Controller.text = '99';
    temperatureController.text = '97.4';
    weightController.text = '38.619';
    heightController.text = '152';
  }

  void onPainLevelSelected(int level) {
    _painLevel = level;
    ref.notifyListeners();
  }

  void onSaveVitals() {
    // Validate required fields
    if (pulseController.text.isEmpty || temperatureController.text.isEmpty) {
      return;
    }

    // TODO: Save vitals to API when ready
    final vitalsData = {
      'pain_level': _painLevel,
      'bp_lying': bpLyingController.text,
      'bp_sitting': bpSittingController.text,
      'bp_standing': bpStandingController.text,
      'pulse': pulseController.text,
      'respiratory_rate': respiratoryRateController.text,
      'spo2': spo2Controller.text,
      'temperature': temperatureController.text,
      'blood_sugar': bloodSugarController.text,
      'height': heightController.text,
      'weight': weightController.text,
    };

    debugPrint('Saving vitals: $vitalsData');

    // Navigate back
    navigationService.pop();
  }
}
