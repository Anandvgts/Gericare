import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';

part 'case_sheet_controller.g.dart';

@riverpod
class CaseSheetController extends _$CaseSheetController {
  /// Patient info (owned by controller)
  String patientName = '';
  String gender = '';
  int age = 0;

  @override
  AsyncValue<void> build(String patientId) {
    _loadPatient(patientId);
    return const AsyncValue.data(null);
  }

  void _loadPatient(String patientId) {
    /// TEMP DATA (replace with API)
    patientName = "Mr. Krishna Kumar";
    gender = "Male";
    age = 74;

    ref.notifyListeners();
  }

  /// ───────── NAVIGATION ─────────

  void openMedications() => navigationService.pushNamed(Routes.csMedications);

  void openVitals() => navigationService.pushNamed(Routes.csVitals);

  void openFluidBalance() => navigationService.pushNamed(Routes.csFluidBlance);

  void openProgressNotes() =>
      navigationService.pushNamed(Routes.csProgressNote);

  void openCarePlan(String patientId) => navigationService.pushNamed(
        Routes.csCarePlan,
        arguments: patientId,
      );

  void openIncidentReport(String patientId) => navigationService.pushNamed(
        Routes.csIncident,
        arguments: patientId,
      );

  void openSugarChart(String patientId) => navigationService.pushNamed(
        Routes.csBloodSugar,
        arguments: patientId,
      );

  void openTreatments(String patientId) => navigationService.pushNamed(
        Routes.csTreatments,
        arguments: patientId,
      );

  void verifyCaseSheet() {
    // TODO: API integration
  }
}
