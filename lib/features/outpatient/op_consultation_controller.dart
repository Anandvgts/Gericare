import 'package:doctor/features/dashboard/dashboard_controller.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'op_consultation_controller.g.dart';

/// Model for OP consultation (used for UI display)
class OpConsultation {
  final String id;
  final int serialNo;
  final String encounterId;
  final String doctorName;
  final String department;
  final String serviceName;
  final String serviceCategory;
  final String centreName;
  final String dateTime;
  final String status;
  final String paymentStatus;
  final bool isDue;
  final String patientId;

  OpConsultation({
    required this.id,
    required this.serialNo,
    required this.encounterId,
    required this.doctorName,
    required this.department,
    required this.serviceName,
    required this.serviceCategory,
    required this.centreName,
    required this.dateTime,
    required this.status,
    required this.paymentStatus,
    this.isDue = false,
    required this.patientId,
  });
}

@riverpod
class OpConsultationController extends _$OpConsultationController {
  String? _selectedServiceType;
  String? get selectedServiceType => _selectedServiceType;

  List<OpConsultation> _ongoingConsultations = [];
  List<OpConsultation> get ongoingConsultations => _ongoingConsultations;

  List<OpConsultation> _pastConsultations = [];
  List<OpConsultation> get pastConsultations => _pastConsultations;

  late PatientSchedule _schedule;
  PatientSchedule get schedule => _schedule;

  @override
  AsyncValue<void> build(PatientSchedule schedule) {
    _schedule = schedule;
    _loadDummyConsultations();
    return const AsyncValue.data(null);
  }

  void _loadDummyConsultations() {
    // Dummy data based on reference screenshot
    _ongoingConsultations = [
      OpConsultation(
        id: '2070',
        serialNo: 1,
        encounterId: '102603061001',
        doctorName: 'pravin kumar',
        department: 'ENT',
        serviceName: 'DOCTOR CONSULTATION A',
        serviceCategory: 'CONSULTATION',
        centreName: _schedule.centreName,
        dateTime: '06/03/2026\n11:20 AM - 11:40 AM',
        status: 'In Assessment',
        paymentStatus: 'Due',
        isDue: true,
        patientId: _schedule.patientId,
      ),
    ];

    // Past consultations (empty for demo, matching reference)
    _pastConsultations = [];
  }

  void onServiceTypeChanged(String? value) {
    _selectedServiceType = value;
    ref.notifyListeners();
  }

  void onPrintSticker() {
    // TODO: Implement print sticker functionality
    debugPrint('Print sticker for patient: ${_schedule.patientId}');
  }

  void onViewConsultation(OpConsultation consultation) {
    navigationService.pushNamed(
      Routes.opConsultationDetail,
      arguments: consultation,
    );
  }

  void onEditConsultation(OpConsultation consultation) {
    navigationService.pushNamed(
      Routes.opConsultationDetail,
      arguments: consultation,
    );
  }

  void onDeleteConsultation(OpConsultation consultation) {
    // TODO: Implement delete consultation with confirmation dialog
    debugPrint('Delete consultation: ${consultation.id}');
  }

  void onContinueAssessment(OpConsultation consultation) {
    navigationService.pushNamed(
      Routes.opConsultationDetail,
      arguments: consultation,
    );
  }
}
