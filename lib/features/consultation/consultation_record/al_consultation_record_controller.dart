import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'al_consultation_record_controller.g.dart';

enum AlConsultationSectionType {
  medicalHistory,
  vitals,
  symptoms,
  findings,
  diagnosis,
  medicines,
  investigations,
  instructions,
  procedures,
  followup,
}

/// Section data model
class AlConsultationSection {
  final AlConsultationSectionType type;
  final String title;
  final IconData icon;
  final List<String> items;
  final bool hasData;

  AlConsultationSection({
    required this.type,
    required this.title,
    required this.icon,
    this.items = const [],
    this.hasData = false,
  });
}

@riverpod
class AlConsultationRecordController extends _$AlConsultationRecordController {
  String _patientId = '';
  bool _hasConsultationData = false;
  bool get hasConsultationData => _hasConsultationData;

  /// Patient info
  String patientName = "Mr. Krishna Kumar";
  String gender = "Male";
  int age = 74;

  /// Sections data
  List<AlConsultationSection> _sections = [];
  List<AlConsultationSection> get sections => _sections;

  @override
  AsyncValue<void> build(String patientId) {
    _patientId = patientId;
    _loadDummyData();
    return const AsyncValue.data(null);
  }

  void _loadDummyData() {
    // Load dummy consultation data
    _hasConsultationData = true; // Set to true to show filled data

    _sections = [
      AlConsultationSection(
        type: AlConsultationSectionType.medicalHistory,
        title: 'Medical History',
        icon: Icons.history,
        items: ['Hypertension - 5 years', 'Diabetes Type 2 - 3 years'],
        hasData: true,
      ),
      AlConsultationSection(
        type: AlConsultationSectionType.vitals,
        title: 'Vitals',
        icon: Icons.monitor_heart,
        items: ['BP: 134/82 mmHg', 'Pulse: 74 bpm', 'Temp: 97.4°F'],
        hasData: true,
      ),
      AlConsultationSection(
        type: AlConsultationSectionType.symptoms,
        title: 'Symptoms',
        icon: Icons.sick_outlined,
        items: ['Mild fatigue', 'Joint pain - knees'],
        hasData: true,
      ),
      AlConsultationSection(
        type: AlConsultationSectionType.findings,
        title: 'Examination Findings',
        icon: Icons.search,
        items: ['Thin build', 'Mild kyphosis'],
        hasData: true,
      ),
      AlConsultationSection(
        type: AlConsultationSectionType.diagnosis,
        title: 'Diagnosis',
        icon: Icons.assignment_outlined,
        items: ['Essential Hypertension', 'Osteoarthritis'],
        hasData: true,
      ),
      AlConsultationSection(
        type: AlConsultationSectionType.medicines,
        title: 'Medicines',
        icon: Icons.medication_outlined,
        items: ['Amlodipine 5mg - Once daily', 'Paracetamol 500mg - As needed'],
        hasData: true,
      ),
      AlConsultationSection(
        type: AlConsultationSectionType.investigations,
        title: 'Investigations',
        icon: Icons.science_outlined,
        items: ['CBC', 'Lipid Profile'],
        hasData: true,
      ),
      AlConsultationSection(
        type: AlConsultationSectionType.instructions,
        title: 'Instructions',
        icon: Icons.description_outlined,
        items: ['Low salt diet', 'Regular walking'],
        hasData: true,
      ),
      AlConsultationSection(
        type: AlConsultationSectionType.procedures,
        title: 'Procedures',
        icon: Icons.medical_services_outlined,
        items: [],
        hasData: false,
      ),
      AlConsultationSection(
        type: AlConsultationSectionType.followup,
        title: 'Follow Up',
        icon: Icons.calendar_today_outlined,
        items: ['After 2 weeks'],
        hasData: true,
      ),
    ];
  }

  void openSection(AlConsultationSectionType type) {
    final args = OpRecordArguments(
      consultationId: _patientId,
      patientId: _patientId,
    );

    switch (type) {
      case AlConsultationSectionType.medicalHistory:
        navigationService.pushNamed(Routes.opMedicalHistory, arguments: args);
        break;
      case AlConsultationSectionType.vitals:
        navigationService.pushNamed(Routes.opVitals, arguments: args);
        break;
      case AlConsultationSectionType.symptoms:
        navigationService.pushNamed(Routes.opSymptoms, arguments: args);
        break;
      case AlConsultationSectionType.findings:
        navigationService.pushNamed(Routes.opFindings, arguments: args);
        break;
      case AlConsultationSectionType.diagnosis:
        navigationService.pushNamed(Routes.opDiagnosis, arguments: args);
        break;
      case AlConsultationSectionType.medicines:
        navigationService.pushNamed(Routes.opMedicines, arguments: args);
        break;
      case AlConsultationSectionType.investigations:
        navigationService.pushNamed(Routes.opInvestigations, arguments: args);
        break;
      case AlConsultationSectionType.instructions:
        navigationService.pushNamed(Routes.opInstructions, arguments: args);
        break;
      case AlConsultationSectionType.procedures:
        navigationService.pushNamed(Routes.opProcedures, arguments: args);
        break;
      case AlConsultationSectionType.followup:
        navigationService.pushNamed(Routes.opFollowup, arguments: args);
        break;
    }
  }

  void onAIAssistanceTap() {
    // TODO: Implement AI Assistance
    debugPrint('AI Assistance tapped');
  }

  void onSaveConsultation() {
    // TODO: Save consultation
    debugPrint('Save consultation');
    navigationService.pop();
  }
}
