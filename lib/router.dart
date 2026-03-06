import 'package:doctor/features/consultation/al_need_assessment/al_need_assessment_view.dart';
import 'package:doctor/features/auth/forgot_password/forgot_password_view.dart';
import 'package:doctor/features/auth/reset_password/reset_password_view.dart';

import 'package:doctor/features/auth/verify_otp/verify_otp_view.dart';
import 'package:doctor/features/consultation/case_sheet/care_paln/care_plan_view.dart';
import 'package:doctor/features/consultation/case_sheet/case_sheet_view.dart';
import 'package:doctor/features/consultation/case_sheet/fluid_balance/fluid_balance_view.dart';
import 'package:doctor/features/consultation/case_sheet/incident/incident_report_view.dart';
import 'package:doctor/features/consultation/case_sheet/incident/incident_view.dart';
import 'package:doctor/features/consultation/case_sheet/medication/medications_view.dart';
import 'package:doctor/features/consultation/case_sheet/progress_notes/progress_note_view.dart';
import 'package:doctor/features/consultation/case_sheet/sugar/blood_sugar_view.dart';
import 'package:doctor/features/consultation/case_sheet/treatments/treatments_view.dart';
import 'package:doctor/features/consultation/case_sheet/vitals/vitals_details_view.dart';
import 'package:doctor/features/consultation/case_sheet/vitals/vitals_view.dart';
import 'package:doctor/features/consultation/consultation_view.dart';
import 'package:doctor/features/dashboard/dashboard_view.dart';
import 'package:doctor/features/dashboard/dashboard_controller.dart';
import 'package:doctor/features/auth/login/login_view.dart';
import 'package:doctor/features/auth/onboarding_view.dart';
import 'package:doctor/features/dashboard/qr_scan_view.dart';
import 'package:doctor/features/auth/splash_view.dart';
import 'package:doctor/features/outpatient/op_consultation_view.dart';
import 'package:doctor/features/outpatient/op_consultation_controller.dart';
import 'package:doctor/features/outpatient/op_consultation_detail_view.dart';
import 'package:doctor/features/outpatient/op_vitals_view.dart';
import 'package:doctor/features/outpatient/consultation_record/op_symptoms_view.dart';
import 'package:doctor/features/outpatient/consultation_record/op_diagnosis_view.dart';
import 'package:doctor/features/outpatient/consultation_record/op_findings_view.dart';
import 'package:doctor/features/outpatient/consultation_record/op_medicines_view.dart';
import 'package:doctor/features/outpatient/consultation_record/op_investigations_view.dart';
import 'package:doctor/features/outpatient/consultation_record/op_instructions_view.dart';
import 'package:doctor/features/outpatient/consultation_record/op_procedures_view.dart';
import 'package:doctor/features/outpatient/consultation_record/op_followup_view.dart';
import 'package:doctor/features/outpatient/consultation_record/op_medical_history_view.dart';
import 'package:doctor/features/consultation/consultation_history/consultation_history_view.dart';
import 'package:doctor/features/consultation/consultation_history/consultation_history_details_view.dart';
import 'package:doctor/features/consultation/consultation_history/consultation_history_controller.dart';
import 'package:doctor/features/consultation/consultation_record/al_consultation_record_view.dart';
import 'package:doctor/features/outpatient/op_consultation_report_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const splash = '/';
  static const getStarted = '/get-started';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const qrScan = '/qr-scan';
  static const forgotPassword = '/forgot-password';
  static const verifyOtp = '/verify-otp';
  static const resetPassword = '/resetPassword';
  static const consultation = '/consultation';
  static const alNeedAssessment = '/al-need-assessment';
  static const caseSheet = '/case-sheet';

  static const csMedications = '/cs-medications';
  static const csVitals = '/cs-vitals';
  static const csVitalsDetails = '/cs-vitals-details';
  static const csFluidBlance = '/cs-fluid-balance';
  static const csProgressNote = '/cs-progress-note';
  static const csCarePlan = '/cs-care-plan';
  static const csIncident = '/cs-incident';
  static const csIncidentReport = '/cs-incident-report';
  static const csBloodSugar = '/cs-blood-sugar';
  static const csTreatments = '/cs-treatments';

  // AL (Assisted Living) Consultation Routes
  static const consultationRecord = '/consultation-record';
  static const consultationHistory = '/consultation-history';
  static const consultationHistoryDetails = '/consultation-history-details';

  // OP (Outpatient) Routes
  static const opConsultation = '/op-consultation';
  static const opConsultationDetail = '/op-consultation-detail';
  static const opVitals = '/op-vitals';
  static const opSymptoms = '/op-symptoms';
  static const opDiagnosis = '/op-diagnosis';
  static const opFindings = '/op-findings';
  static const opMedicines = '/op-medicines';
  static const opMedicineDosage = '/op-medicine-dosage';
  static const opInvestigations = '/op-investigations';
  static const opInstructions = '/op-instructions';
  static const opProcedures = '/op-procedures';
  static const opFollowup = '/op-followup';
  static const opMedicalHistory = '/op-medical-history';
  static const opConsultationReport = '/op-consultation-report';
}

class VerifyOtpArguments {
  final String identifier;
  final String exchangeKey;
  VerifyOtpArguments({required this.identifier, required this.exchangeKey});
}

class ResetPasswordArguments {
  final String identifier;
  final String exchangeKey;
  ResetPasswordArguments({required this.identifier, required this.exchangeKey});
}

/// Arguments for OP consultation record screens
class OpRecordArguments {
  final String consultationId;
  final String? patientId;

  OpRecordArguments({required this.consultationId, this.patientId});
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.getStarted:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordView(),
        );
      case Routes.verifyOtp:
        final args = settings.arguments as VerifyOtpArguments;

        return MaterialPageRoute(
          builder: (_) => VerifyOtpView(args: args),
        );
      case Routes.resetPassword:
        final args = settings.arguments as ResetPasswordArguments;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordView(
            args: ResetPasswordArguments(
                identifier: args.identifier, exchangeKey: args.exchangeKey),
          ),
        );
      case Routes.qrScan:
        return MaterialPageRoute(
          builder: (_) => const QrScanView(),
        );

      case Routes.consultation:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ConsultationView(patientId: patientId),
        );

      case Routes.alNeedAssessment:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AlNeedAssessmentView(patientId: patientId),
        );
      case Routes.caseSheet:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CaseSheetView(patientId: patientId),
        );
      case Routes.csMedications:
        return MaterialPageRoute(
          builder: (_) => MedicationsView(),
        );
      case Routes.csVitals:
        return MaterialPageRoute(
          builder: (_) => VitalsView(),
        );
      case Routes.csVitalsDetails:
        return MaterialPageRoute(
          builder: (_) => VitalsDetailView(),
        );
      case Routes.csFluidBlance:
        return MaterialPageRoute(
          builder: (_) => FluidBalanceView(),
        );
      case Routes.csProgressNote:
        return MaterialPageRoute(
          builder: (_) => ProgressNotesView(),
        );
      case Routes.csCarePlan:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CarePlanView(patientId: patientId),
        );

      case Routes.csIncident:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => IncidentView(patientId: patientId),
        );

      case Routes.csIncidentReport:
        // final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => IncidentReportView(
            args: IncidentReportArgs(
                patientName: 'Test',
                dateLabel: '12/01/2026',
                type: 'New',
                location: 'chennai',
                witness: 'Brother',
                notes: 'check teh flows',
                attachments: []),
          ),
        );
      case Routes.csBloodSugar:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BloodSugarView(patientId: patientId),
        );
      case Routes.csTreatments:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => TreatmentsView(patientId: patientId),
        );

      // AL Consultation Routes
      case Routes.consultationRecord:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AlConsultationRecordView(patientId: patientId),
        );

      case Routes.consultationHistory:
        final patientId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ConsultationHistoryView(patientId: patientId),
        );

      case Routes.consultationHistoryDetails:
        final item = settings.arguments as ConsultationHistoryItem;
        return MaterialPageRoute(
          builder: (_) => ConsultationHistoryDetailsView(item: item),
        );

      // OP (Outpatient) Routes
      case Routes.opConsultation:
        final schedule = settings.arguments as PatientSchedule;
        return MaterialPageRoute(
          builder: (_) => OpConsultationView(schedule: schedule),
        );

      case Routes.opConsultationDetail:
        final consultation = settings.arguments as OpConsultation;
        return MaterialPageRoute(
          builder: (_) => OpConsultationDetailView(consultation: consultation),
        );

      case Routes.opVitals:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpVitalsView(consultationId: args.consultationId),
        );

      case Routes.opSymptoms:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpSymptomsView(consultationId: args.consultationId),
        );

      case Routes.opDiagnosis:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpDiagnosisView(consultationId: args.consultationId),
        );

      case Routes.opFindings:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpFindingsView(consultationId: args.consultationId),
        );

      case Routes.opMedicines:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpMedicinesView(consultationId: args.consultationId),
        );

      case Routes.opMedicineDosage:
        final medicineName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => OpMedicineDosageView(medicineName: medicineName),
        );

      case Routes.opInvestigations:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpInvestigationsView(consultationId: args.consultationId),
        );

      case Routes.opInstructions:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpInstructionsView(consultationId: args.consultationId),
        );

      case Routes.opProcedures:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpProceduresView(consultationId: args.consultationId),
        );

      case Routes.opFollowup:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpFollowupView(consultationId: args.consultationId),
        );

      case Routes.opMedicalHistory:
        final args = settings.arguments as OpRecordArguments;
        return MaterialPageRoute(
          builder: (_) => OpMedicalHistoryView(patientId: args.patientId!),
        );

      case Routes.opConsultationReport:
        final consultationId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => OpConsultationReportView(consultationId: consultationId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
