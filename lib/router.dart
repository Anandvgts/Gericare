import 'package:flutter/material.dart';
import 'package:gericare_doctor/ui/views/auth/forgot_password/forgot_password_view.dart';
import 'package:gericare_doctor/ui/views/auth/get_started/get_started_view.dart';
import 'package:gericare_doctor/ui/views/auth/login/login_view.dart';
import 'package:gericare_doctor/ui/views/auth/reset_password/reset_password_view.dart';
import 'package:gericare_doctor/ui/views/auth/splash/splash_view.dart';
import 'package:gericare_doctor/ui/views/auth/verify_otp/verify_otp_view.dart';
import 'package:gericare_doctor/ui/views/auth/verify_otp/verify_otp_view_model.dart';
import 'package:gericare_doctor/ui/views/case_sheet/case_sheet_view.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/bs_history_view.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/cp_history.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/fluid_blance_view.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/incident_history_view.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/medication_view.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/progress_note_view.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/treatements_view.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/vital_history_details.dart';
import 'package:gericare_doctor/ui/views/case_sheet/sub_pages/vitals_history.dart';
import 'package:gericare_doctor/ui/views/consultation/al_need_assessment_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/ai_assistance/ai_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/consultation_record_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/diagnosis/diagnosis_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/findings/findings_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/follow_up/followup_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/instruction/instruction_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/investigations/investigations_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/medical_history/medical_history_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/medicine/medicine_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/procedure/procedure_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/symptoms/symptoms_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_record/vitals/vitals_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_history/ch_details/ch_details_view.dart';
import 'package:gericare_doctor/ui/views/consultation/consultation_history/consultation_history_view.dart';
import 'package:gericare_doctor/ui/views/dashboard/dashboard_view.dart';
import 'package:gericare_doctor/ui/widgets/pdf_viewer.dart';

class Routes {
  static const splash = '/';
  static const getStarted = '/get-started';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const verifyOtp = '/verify-otp';
  static const dashboard = '/dashboard';
  static const resetPassword = '/resetPassword';
  static const consultationRecord = '/consultation-record';
  static const consultation = '/consultation';
  static const alNeedAssessment = '/al-need-assessment';
  static const aiAssistance = '/aiAssistance';
  static const medicalHistory = '/MedicalHistory';
  static const consultationHistory = '/consultation-history';
  static const consultationHistoryDetails = '/consultation-history-details';
  static const medicines = '/medicines';
  static const vitals = '/vitals';
  static const symptoms = '/symptoms';
  static const findings = '/findings';
  static const diagnosis = '/diagnosis';
  static const investigation = '/investigation';
  static const instruction = '/instruction';
  static const procedure = '/procedure';
  static const followup = '/followup';
  static const caseSheet = '/case-sheet';
  static const csMedications = '/csMedications';
  static const csTreatments = '/csTreatments';
  static const csVitalsHistory = '/csVitalsHistory';
  static const csVitalsHistoryDetails = '/csVitalsHistoryDetails';
  static const csFluidBlance = '/csFluidBlance';
  static const csProgressNote = '/csProgressNote';
  static const csBloodSugar = '/csBloodSugar';
  static const csCarePlan = '/csCarePlan';
  static const csIncident = '/csIncident';
  static const pdfViewer = '/pdf-viewer';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.getStarted:
        return MaterialPageRoute(builder: (_) => const GetStartedView());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.verifyOtp:
        final flow = settings.arguments as OtpFlow;
        return MaterialPageRoute(
          builder: (_) => VerifyOtpView(flow: flow),
        );

      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPasswordView());
      case Routes.dashboard:
        return MaterialPageRoute(builder: (_) => DashboardView());
      case Routes.consultation:
        return MaterialPageRoute(builder: (_) => ConsultationView());
      case Routes.consultationRecord:
        return MaterialPageRoute(
            builder: (_) => ConsultationRecordView(
                  hasConsultationData: false,
                ));
      case Routes.medicalHistory:
        return MaterialPageRoute(builder: (_) => MedicalHistoryView());
      case Routes.alNeedAssessment:
        return MaterialPageRoute(builder: (_) => AlNeedAssessmentView());
      case Routes.aiAssistance:
        return MaterialPageRoute(builder: (_) => AIAssistanceView());
      case Routes.consultationHistory:
        return MaterialPageRoute(builder: (_) => ConsultationHistoryView());
      case Routes.consultationHistoryDetails:
        return MaterialPageRoute(
            builder: (_) => ConsultationHistoryDetailsView());
      case Routes.symptoms:
        return MaterialPageRoute(builder: (_) => SymptomsView());
      case Routes.vitals:
        return MaterialPageRoute(builder: (_) => VitalsView());
      case Routes.findings:
        return MaterialPageRoute(builder: (_) => FindingsView());
      case Routes.diagnosis:
        return MaterialPageRoute(builder: (_) => DiagnosisView());
      case Routes.medicines:
        return MaterialPageRoute(builder: (_) => MedicinesView());
      case Routes.investigation:
        return MaterialPageRoute(builder: (_) => InvestigationsView());
      case Routes.instruction:
        return MaterialPageRoute(builder: (_) => InstructionsView());
      case Routes.procedure:
        return MaterialPageRoute(builder: (_) => ProceduresView());
      case Routes.followup:
        return MaterialPageRoute(builder: (_) => FollowUpNotesView());
      case Routes.caseSheet:
        return MaterialPageRoute(builder: (_) => CaseSheetView());
      case Routes.csMedications:
        return MaterialPageRoute(builder: (_) => MedicationsView());
      case Routes.csTreatments:
        return MaterialPageRoute(builder: (_) => TreatmentsView());
      case Routes.csVitalsHistory:
        return MaterialPageRoute(builder: (_) => VitalsHistoryView());
      case Routes.csVitalsHistoryDetails:
        return MaterialPageRoute(
            builder: (_) => VitalsDetailView(dateTime: DateTime.now()));
      case Routes.csProgressNote:
        return MaterialPageRoute(builder: (_) => ProgressNotesView());
      case Routes.csFluidBlance:
        return MaterialPageRoute(builder: (_) => FluidBalanceView());
      case Routes.csBloodSugar:
        return MaterialPageRoute(builder: (_) => BloodSugarHistoryView());
      case Routes.csCarePlan:
        return MaterialPageRoute(builder: (_) => CarePlanHistoryView());
      case Routes.csIncident:
        return MaterialPageRoute(builder: (_) => IncidentHistoryView());
      case Routes.pdfViewer:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => PdfViewerView(
            filePath: args['filePath'],
            title: args['title'],
            date: args['date'],
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
