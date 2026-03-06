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
import 'package:doctor/features/auth/login/login_view.dart';
import 'package:doctor/features/auth/onboarding_view.dart';
import 'package:doctor/features/dashboard/qr_scan_view.dart';
import 'package:doctor/features/auth/splash_view.dart';
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

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
