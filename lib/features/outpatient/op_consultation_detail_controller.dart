import 'package:doctor/features/outpatient/op_consultation_controller.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_consultation_detail_controller.g.dart';

enum ConsultationSectionType {
  aiSummary,
  consultationReport,
  medicalHistory,
  vitals,
  symptoms,
  findings,
  diagnosis,
  medicines,
  instructionsInvestigationsProcedures,
  followup,
}

/// Dummy AI Summary data model
class AISummaryData {
  final String patientName;
  final String ageDobGender;
  final String mrnUhid;
  final String dateOfVisit;
  final String consultingDoctor;
  final String departmentSpecialty;
  final Map<String, String> vitals;
  final List<String> chiefComplaints;
  final List<String> diagnosis;
  final List<String> clinicalFindings;
  final List<String> medicines;
  final List<String> investigations;
  final List<String> instructions;
  final String? followupDate;

  AISummaryData({
    required this.patientName,
    required this.ageDobGender,
    required this.mrnUhid,
    required this.dateOfVisit,
    required this.consultingDoctor,
    required this.departmentSpecialty,
    required this.vitals,
    required this.chiefComplaints,
    required this.diagnosis,
    required this.clinicalFindings,
    this.medicines = const [],
    this.investigations = const [],
    this.instructions = const [],
    this.followupDate,
  });
}

@riverpod
class OpConsultationDetailController extends _$OpConsultationDetailController {
  int _selectedMenuIndex = 0;
  int get selectedMenuIndex => _selectedMenuIndex;

  late OpConsultation _consultation;
  OpConsultation get consultation => _consultation;

  bool get isVitalsComplete => true; // Demo: vitals are complete

  // Dummy AI Summary data
  late AISummaryData _aiSummary;
  AISummaryData get aiSummary => _aiSummary;

  final List<ConsultationSectionType> menuItems = [
    ConsultationSectionType.aiSummary,
    ConsultationSectionType.consultationReport,
    ConsultationSectionType.medicalHistory,
    ConsultationSectionType.vitals,
    ConsultationSectionType.symptoms,
    ConsultationSectionType.findings,
    ConsultationSectionType.diagnosis,
    ConsultationSectionType.medicines,
    ConsultationSectionType.instructionsInvestigationsProcedures,
    ConsultationSectionType.followup,
  ];

  @override
  AsyncValue<void> build(OpConsultation consultation) {
    _consultation = consultation;
    _loadDummyAISummary();
    return const AsyncValue.data(null);
  }

  void _loadDummyAISummary() {
    // Dummy AI Summary data based on reference screenshot
    _aiSummary = AISummaryData(
      patientName: 'Ms. N LOGANAYAKI',
      ageDobGender: '86 Years 4 Months 22 Days / F',
      mrnUhid: '910014644',
      dateOfVisit: '27/02/2026',
      consultingDoctor: 'Dr. R. Magesh',
      departmentSpecialty: 'Department of Geriatrics',
      vitals: {
        'BP': '134/82 mmHg',
        'Heart Rate': '74 bpm',
        'Temperature': '97.4 °F',
        'SpO2': '99 % (RA)',
        'Weight': '38.619 kg',
      },
      chiefComplaints: [
        'Tongue gets dry - long term, now getting worse.',
        'Throat - dry, burning.',
      ],
      diagnosis: [
        '? Acid reflux disease.',
        '? B12 def.',
      ],
      clinicalFindings: [
        'Thin, Kyphosis (+)',
      ],
      instructions: [
        'Inadequate beta glucan intake (440431000124105)',
        'Adolescent and young adult oncology care (1351996009)',
      ],
    );
  }

  void onMenuTap(int index) {
    _selectedMenuIndex = index;
    ref.notifyListeners();
  }

  void onPrint() {
    // TODO: Implement print functionality
    debugPrint('Print prescription for consultation: ${_consultation.id}');
  }

  void onDownload() {
    // TODO: Implement download functionality
    debugPrint('Download prescription for consultation: ${_consultation.id}');
  }

  void onUploadMedicalHistory() {
    // TODO: Implement file picker
    debugPrint('Upload medical history');
  }

  void onAddMedicalHistoryPage() {
    // TODO: Add page
    debugPrint('Add medical history page');
  }

  void onRecordVitals() {
    navigationService.pushNamed(
      Routes.opVitals,
      arguments: OpRecordArguments(consultationId: _consultation.id),
    );
  }

  void openSection(ConsultationSectionType type) {
    final args = OpRecordArguments(
      consultationId: _consultation.id,
      patientId: _consultation.patientId,
    );

    switch (type) {
      case ConsultationSectionType.aiSummary:
        // AI Summary is shown inline, no navigation needed
        break;
      case ConsultationSectionType.consultationReport:
        navigationService.pushNamed(Routes.opConsultationReport, arguments: _consultation.id);
        break;
      case ConsultationSectionType.medicalHistory:
        navigationService.pushNamed(Routes.opMedicalHistory, arguments: args);
        break;
      case ConsultationSectionType.vitals:
        navigationService.pushNamed(Routes.opVitals, arguments: args);
        break;
      case ConsultationSectionType.symptoms:
        navigationService.pushNamed(Routes.opSymptoms, arguments: args);
        break;
      case ConsultationSectionType.findings:
        navigationService.pushNamed(Routes.opFindings, arguments: args);
        break;
      case ConsultationSectionType.diagnosis:
        navigationService.pushNamed(Routes.opDiagnosis, arguments: args);
        break;
      case ConsultationSectionType.medicines:
        navigationService.pushNamed(Routes.opMedicines, arguments: args);
        break;
      case ConsultationSectionType.instructionsInvestigationsProcedures:
        // Open instructions page (can navigate to investigations/procedures from there)
        navigationService.pushNamed(Routes.opInstructions, arguments: args);
        break;
      case ConsultationSectionType.followup:
        navigationService.pushNamed(Routes.opFollowup, arguments: args);
        break;
    }
  }

  void onSubmitConsultation() {
    // TODO: Submit consultation to API when ready
    debugPrint('Submitting consultation: ${_consultation.id}');
    navigationService.pop();
  }

  String getSectionTitle(ConsultationSectionType type) {
    switch (type) {
      case ConsultationSectionType.aiSummary:
        return 'AI Summary';
      case ConsultationSectionType.consultationReport:
        return 'Consultation Report';
      case ConsultationSectionType.medicalHistory:
        return 'Medical History';
      case ConsultationSectionType.vitals:
        return 'Vitals';
      case ConsultationSectionType.symptoms:
        return 'Symptoms';
      case ConsultationSectionType.findings:
        return 'Examination Findings';
      case ConsultationSectionType.diagnosis:
        return 'Diagnosis';
      case ConsultationSectionType.medicines:
        return 'Medicines';
      case ConsultationSectionType.instructionsInvestigationsProcedures:
        return 'Instructions, Investigations & Procedures';
      case ConsultationSectionType.followup:
        return 'Followup';
    }
  }

  IconData getSectionIcon(ConsultationSectionType type) {
    switch (type) {
      case ConsultationSectionType.aiSummary:
        return Icons.auto_awesome;
      case ConsultationSectionType.consultationReport:
        return Icons.article_outlined;
      case ConsultationSectionType.medicalHistory:
        return Icons.history;
      case ConsultationSectionType.vitals:
        return Icons.monitor_heart;
      case ConsultationSectionType.symptoms:
        return Icons.coronavirus;
      case ConsultationSectionType.findings:
        return Icons.healing;
      case ConsultationSectionType.diagnosis:
        return Icons.assignment;
      case ConsultationSectionType.medicines:
        return Icons.medication;
      case ConsultationSectionType.instructionsInvestigationsProcedures:
        return Icons.description;
      case ConsultationSectionType.followup:
        return Icons.calendar_today;
    }
  }
}
