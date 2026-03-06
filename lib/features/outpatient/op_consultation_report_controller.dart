import 'package:doctor/features/outpatient/data/op_models.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_consultation_report_controller.g.dart';

/// Consultation Report data model
class ConsultationReportData {
  final String encounterId;
  final String patientName;
  final String uhid;
  final String ageGender;
  final String location;
  final String date;
  final String department;
  final String doctorName;
  final String doctorQualification;
  final String doctorRegistration;
  final List<ReportMedicineItem> medicines;
  final List<String> instructions;
  final List<String> investigations;
  final String? followupDate;
  final String? followupNotes;

  ConsultationReportData({
    required this.encounterId,
    required this.patientName,
    required this.uhid,
    required this.ageGender,
    required this.location,
    required this.date,
    required this.department,
    required this.doctorName,
    required this.doctorQualification,
    required this.doctorRegistration,
    this.medicines = const [],
    this.instructions = const [],
    this.investigations = const [],
    this.followupDate,
    this.followupNotes,
  });
}

/// Medicine item for the report table
class ReportMedicineItem {
  final String medication;
  final String dosage;
  final String quantity;
  final String frequencyIntake;
  final String duration;
  final String? instruction;

  ReportMedicineItem({
    required this.medication,
    required this.dosage,
    required this.quantity,
    required this.frequencyIntake,
    required this.duration,
    this.instruction,
  });
}

@riverpod
class OpConsultationReportController extends _$OpConsultationReportController {
  late String _consultationId;
  late ConsultationReportData _reportData;
  ConsultationReportData get reportData => _reportData;

  @override
  AsyncValue<void> build(String consultationId) {
    _consultationId = consultationId;
    _loadDummyReportData();
    return const AsyncValue.data(null);
  }

  void _loadDummyReportData() {
    // Dummy report data matching reference screenshot
    _reportData = ConsultationReportData(
      encounterId: 'ENC-2096-27022026',
      patientName: 'Ms. N LOGANAYAKI',
      uhid: '910014644',
      ageGender: '86Y 4M / Female',
      location: 'Nandanam - General',
      date: '27/02/2026',
      department: 'Department of Geriatrics',
      doctorName: 'Dr. R. Magesh',
      doctorQualification: 'MBBS, MD (Geriatric Medicine)',
      doctorRegistration: 'Reg. No: TN/MC/2015/12345',
      medicines: [
        ReportMedicineItem(
          medication: 'Tab. Amlodipine 5mg',
          dosage: '5mg',
          quantity: '30',
          frequencyIntake: '1-0-0 / After Food',
          duration: '30 Days',
          instruction: 'Take in the morning',
        ),
        ReportMedicineItem(
          medication: 'Tab. Metformin 500mg',
          dosage: '500mg',
          quantity: '60',
          frequencyIntake: '1-0-1 / After Food',
          duration: '30 Days',
          instruction: 'Monitor blood sugar levels',
        ),
        ReportMedicineItem(
          medication: 'Cap. Omeprazole 20mg',
          dosage: '20mg',
          quantity: '30',
          frequencyIntake: '1-0-0 / Before Food',
          duration: '30 Days',
          instruction: 'Take 30 mins before breakfast',
        ),
        ReportMedicineItem(
          medication: 'Tab. Paracetamol 500mg',
          dosage: '500mg',
          quantity: '10',
          frequencyIntake: 'SOS',
          duration: 'As needed',
          instruction: 'Take for fever/pain, max 4 tablets/day',
        ),
        ReportMedicineItem(
          medication: 'Syp. Lactulose 10ml',
          dosage: '10ml',
          quantity: '200ml',
          frequencyIntake: '0-0-1 / After Food',
          duration: '20 Days',
          instruction: 'Take at bedtime',
        ),
      ],
      instructions: [
        'Low salt, low sugar diet recommended',
        'Regular walking for 20-30 minutes daily',
        'Adequate fluid intake (6-8 glasses/day)',
        'Monitor blood pressure daily',
        'Take medications regularly as prescribed',
        'Report immediately if any unusual symptoms',
      ],
      investigations: [
        'Complete Blood Count (CBC)',
        'Lipid Profile',
        'HbA1c',
        'Renal Function Test (RFT)',
        'Thyroid Profile (T3, T4, TSH)',
      ],
      followupDate: '13/03/2026',
      followupNotes: 'Review with investigation reports',
    );
  }

  void onPrint() {
    debugPrint('Printing consultation report for: $_consultationId');
    // TODO: Implement PDF generation and print
  }

  void onDownload() {
    debugPrint('Downloading consultation report for: $_consultationId');
    // TODO: Implement PDF download
  }

  void onLetterpadPrint() {
    debugPrint('Letterpad printing for: $_consultationId');
    // TODO: Implement letterpad format print
  }

  void onShare() {
    debugPrint('Sharing consultation report for: $_consultationId');
    // TODO: Implement share functionality
  }
}
