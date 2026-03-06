// import 'package:doctor/locator.dart';
// import 'package:doctor/router.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';

// /// 🔹 PROVIDER (FAMILY)
// final consultationViewModelProvider =
//     ChangeNotifierProvider.family<ConsultationViewModel, String>(
//   (ref, patientId) => ConsultationViewModel(patientId: patientId),
// );

// class ConsultationViewModel extends ChangeNotifier {
//   final String patientId;

//   ConsultationViewModel({required this.patientId}) {
//     _loadPatient();
//   }

//   String patientName = "";
//   String gender = "";
//   int age = 0;

//   void _loadPatient() {
//     // 🔹 TEMP (replace with API later)
//     patientName = "Mr. Krishna Kumar";
//     gender = "Male";
//     age = 74;
//     notifyListeners();
//   }

//   /// ───────────────────────── NAVIGATION ─────────────────────────

//   void onAlNeedAssessmentTap() {
//     navigationService.pushNamed(
//       Routes.alNeedAssessment,
//       arguments: patientId,
//     );
//   }

//   void onConsultationTap() {
//     // navigationService.pushNamed(
//     //   Routes.consultationRecord,
//     //   arguments: patientId,
//     // );
//   }

//   void onViewHistoryTap() {
//     // navigationService.pushNamed(
//     //   Routes.consultationHistory,
//     //   arguments: patientId,
//     // );
//   }

//   void onCaseSheetTap() {
//     navigationService.pushNamed(
//       Routes.caseSheet,
//       arguments: patientId,
//     );
//   }

//   void onNewReportTap() {
//     // TODO: open new report
//   }

//   void onReviewedReportTap() {
//     // TODO: open reviewed report
//   }
// }

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';

part 'consultation_controller.g.dart';

@riverpod
class ConsultationController extends _$ConsultationController {
  /// Patient info
  String patientName = "";
  String gender = "";
  int age = 0;

  @override
  AsyncValue<void> build(String patientId) {
    _loadPatient(patientId);

    return const AsyncValue.data(null);
  }

  void _loadPatient(String patientId) {
    /// TEMP DATA (replace with API later)
    patientName = "Mr. Krishna Kumar";
    gender = "Male";
    age = 74;

    ref.notifyListeners();
  }

  /// ───────────── NAVIGATION ─────────────

  void onAlNeedAssessmentTap() {
    navigationService.pushNamed(
      Routes.alNeedAssessment,
      arguments: patientId,
    );
  }

  void onConsultationTap() {
    navigationService.pushNamed(
      Routes.consultationRecord,
      arguments: patientId,
    );
  }

  void onViewHistoryTap() {
    navigationService.pushNamed(
      Routes.consultationHistory,
      arguments: patientId,
    );
  }

  void onCaseSheetTap() {
    navigationService.pushNamed(
      Routes.caseSheet,
      arguments: patientId,
    );
  }

  void onNewReportTap() {
    // TODO
  }

  void onReviewedReportTap() {
    // TODO
  }
}
