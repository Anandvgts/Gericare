import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/router.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_history/ch_details/ch_details_view_model.dart';

enum ConsultationSectionType {
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

class ConsultationRecordViewModel extends VGTSBaseViewModel {
  final bool hasConsultationData;

  ConsultationRecordViewModel({required this.hasConsultationData});

  void onSectionTap(String section) {
    navigationService.pushNamed(
      '/consultation/$section',
    );
  }

  final List<ConsultationDetailSection> sections = [
    /// Medical History
    ConsultationDetailSection(
      type: ConsultationSectionType.medicalHistory,
      title: "Medical History",
      icon: "assets/main/diagnosis.png",
      rows: [
        ConsultationRow(
          left: "Hypertension",
          rightLabel: "Duration",
          rightValue: "0–3 Months",
          extraLabel: "Medication",
          extraValue: "G2K (400 mg), G2K (200 mg)",
        ),
        ConsultationRow(
          left: "Hypothyroidism",
          rightLabel: "Duration",
          rightValue: "3–6 Months",
          extraLabel: "Medication",
          extraValue: "G2K (400 mg), G2K (200 mg)",
        ),
      ],
    ),

    /// Vitals
    ConsultationDetailSection(
      type: ConsultationSectionType.vitals,
      title: "Vitals",
      icon: "assets/main/vitals.png",
      layoutType: SectionLayoutType.vitals,
      rows: [
        ConsultationRow(
          left: "Blood Pressure",
          rightValue: "120 mmHg",
          status: "Normal",
        ),
        ConsultationRow(
          left: "Glucose",
          rightValue: "96 mg/dl",
          status: "Normal",
        ),
      ],
    ),

    /// ---------------- Symptoms ----------------
    ConsultationDetailSection(
      type: ConsultationSectionType.symptoms,
      title: "Symptoms",
      icon: "assets/main/symptoms.png",
      rows: [
        ConsultationRow(
          left: "Fever",
          rightLabel: "Duration",
          rightValue: "3 Days, Mild",
          extraLabel: "Notes",
          extraValue: "Continue old medicines",
        ),
        ConsultationRow(
          left: "Cough",
          rightLabel: "Duration",
          rightValue: "3 Days, Mild",
        ),
      ],
    ),

    /// ---------------- Findings ----------------
    ConsultationDetailSection(
      type: ConsultationSectionType.findings,
      title: "Findings",
      icon: "assets/main/findings.png",
      rows: [
        ConsultationRow(
          left: "Dry Cough",
          rightLabel: "Duration",
          rightValue: "3 Days, Mild",
          extraLabel: "Notes",
          extraValue: "Continue old medicines",
        ),
        ConsultationRow(
          left: "Pain in throat",
          rightLabel: "Duration",
          rightValue: "3 Days, Mild",
          extraLabel: "Medication",
          extraValue: "G2K (400 mg), G2K (200 mg)",
        ),
      ],
    ),

    /// ---------------- Diagnosis ----------------
    ConsultationDetailSection(
      type: ConsultationSectionType.diagnosis,
      title: "Diagnosis",
      icon: "assets/main/diagnosis.png",
      rows: [
        ConsultationRow(
          left: "URTI Upper Respiratory Tract Infection",
          rightLabel: "Location",
          rightValue: "Location A",
          extraLabel: "Description",
          extraValue: "To rule out\nWith : Mild",
        ),
        ConsultationRow(
          left: "Fever",
          rightLabel: "Location",
          rightValue: "Head",
          extraLabel: "Description",
          extraValue: "To rule out",
        ),
      ],
    ),

    /// ---------------- Medicines ----------------
    ConsultationDetailSection(
      type: ConsultationSectionType.medicines,
      title: "Medicines",
      icon: "assets/main/medicines.png",
      rows: [
        ConsultationRow(
          left: "Tablet Dolo (650 mg)",
          rightValue: "1 tablet – Twice a week X 3 Days",
        ),
        ConsultationRow(
          left: "Tablet Azithral (500 mg)",
          rightValue: "Stopped",
          status: "Stopped", // handled by UI
        ),
      ],
    ),

    /// Investigations
    ConsultationDetailSection(
      type: ConsultationSectionType.investigations,
      title: "Investigations",
      icon: "assets/main/investigations.png",
      layoutType: SectionLayoutType.groupedBullet,
      groupedItems: {
        "Old": [
          "Widal Test",
          "CBC",
          "Complete Blood Count Haemogram",
        ],
        "New": [
          "X Ray Chest",
          "CBC – Complete Blood Count",
        ],
      },
    ),

    /// Instructions
    ConsultationDetailSection(
      type: ConsultationSectionType.instructions,
      title: "Instructions",
      icon: "assets/main/instructions.png",
      layoutType: SectionLayoutType.bullet,
      groupedItems: {
        "": [
          "Steam Inhalation",
          "Plenty of fluids",
        ],
      },
    ),

    /// Procedures
    ConsultationDetailSection(
      type: ConsultationSectionType.procedures,
      title: "Procedures",
      icon: "assets/main/procedures.png",
      layoutType: SectionLayoutType.bullet,
      groupedItems: {
        "": [
          "Injection",
          "Laparoscopic cholecystectomy",
          "Circumcision",
          "Colonoscopy",
        ],
      },
    ),
  ];

  void onStartAI() {}
  void onSavePrescription() {}

  void onAIAssistanceTap() => navigationService.pushNamed(Routes.aiAssistance);

  void openSection(ConsultationSectionType type) {
    navigationService.pushNamed(
      _routeForSection(type),
      arguments: {
        'isEdit': hasConsultationData,
      },
    );
  }

  String _routeForSection(ConsultationSectionType type) {
    switch (type) {
      case ConsultationSectionType.medicalHistory:
        return Routes.medicalHistory;
      case ConsultationSectionType.vitals:
        return Routes.vitals;
      case ConsultationSectionType.symptoms:
        return Routes.symptoms;

      case ConsultationSectionType.findings:
        return Routes.findings;

      case ConsultationSectionType.diagnosis:
        return Routes.diagnosis;

      case ConsultationSectionType.medicines:
        return Routes.medicines;

      case ConsultationSectionType.investigations:
        return Routes.investigation;
      case ConsultationSectionType.instructions:
        return Routes.instruction;
      case ConsultationSectionType.procedures:
        return Routes.procedure;

      case ConsultationSectionType.followup:
        return Routes.followup;
    }
  }
}
