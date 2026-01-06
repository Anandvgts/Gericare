import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/router.dart';
import 'package:gericare_doctor/ui/views/consultation/al_need_assessment_view.dart';

class ConsultationViewModel extends VGTSBaseViewModel {
  final String patientId;

  ConsultationViewModel({required this.patientId});

  /// Patient Details
  void onAlNeedAssessmentTap() {
    navigationService.pushNamed(
      Routes.alNeedAssessment,
      arguments: patientId,
    );
  }

  /// Consultation
  void onConsultationTap() {
    navigationService.pushNamed(
      Routes.consultationRecord,
    );
  }

  /// Consultation History
  void onViewHistoryTap() {
    navigationService.pushNamed(
      Routes.consultationHistory,
      arguments: patientId,
    );
  }

  /// Case Sheet
  void onCaseSheetTap() {
    navigationService.pushNamed(
      Routes.caseSheet,
      arguments: patientId,
    );
  }

  /// Report PDF
  void onReportTap({
    required String reportId,
    required String pdfUrl,
  }) {
    navigationService.pushNamed(
      Routes.pdfViewer,
      arguments: {
        'filePath': 'assets/main/test.pdf',
        "title": reportId,
        "date": DateTime.now().toIso8601String(),
      },
    );
  }

  ///Al Need Assessment
  /// Patient header
  final String patientName = "Mr. Krishna Kumar";
  final String gender = "Male";
  final int age = 74;

  /// Caller & Patient Details
  final List<InfoRowData> callerDetails = [
    InfoRowData("Caller Name", "Arun Kumar"),
    InfoRowData("Location", "T Nagar"),
    InfoRowData("UHID", "#987654"),
    InfoRowData("Lead ID", "0938754"),
    InfoRowData("Preferred Location", "RA Puram"),
    InfoRowData("Patient Name", "Kishore Nayak"),
    InfoRowData("Current Location", "RA Puram"),
    InfoRowData("Stay Type", "Long Stay (>1 month)"),
    InfoRowData("Current Ailments", "--"),
    InfoRowData("Stay Requirements", "Couple Stay"),
    InfoRowData("Date of Site Visit", "20/05/2025"),
    InfoRowData("Admission Planned On", "30/05/2025"),
    InfoRowData("Agreed Tariff", "--"),
  ];

  /// Functional Status
  final List<InfoRowData> functionalStatus = [
    InfoRowData("Bathing and Dressing", "Minimal Assistance"),
    InfoRowData("Toileting", "Minimal Assistance"),
    InfoRowData("Transferring", "Self"),
    InfoRowData("Continence", "Self"),
    InfoRowData("Feeding", "Self"),
    InfoRowData("Ambulation Support", "No"),
    InfoRowData("Medications", "Minimal Assistance"),
    InfoRowData("Airway", "Minimal Assistance"),
  ];

  /// Assessment Forms
  final List<InfoRowData> assessmentForms = [
    InfoRowData(
      "Clinical Forms",
      "Clinical Frailty Scale, Grip Test, Mini COG, MOCA",
    ),
    InfoRowData(
      "Non-Clinical Forms",
      "GCS Score, Early warning score",
    ),
  ];

  ///
}
