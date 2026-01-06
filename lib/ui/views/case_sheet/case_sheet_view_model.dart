import 'package:flutter/cupertino.dart';
import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/router.dart';

class CaseSheetViewModel extends VGTSBaseViewModel {
  void openMedications() {
    navigationService.pushNamed(Routes.csMedications);
  }

  void openVitals() {
    navigationService.pushNamed(Routes.csVitalsHistory);
  }

  void openFluidBalance() {
    navigationService.pushNamed(Routes.csFluidBlance);
  }

  void openProgressNotes() {
    navigationService.pushNamed(Routes.csProgressNote);
  }

  void openCarePlan() {
    navigationService.pushNamed(Routes.csCarePlan);
  }

  void openIncidentReport() {
    navigationService.pushNamed(Routes.csIncident);
  }

  void openSugarChart() {
    navigationService.pushNamed(Routes.csBloodSugar);
  }

  void openTreatments() {
    navigationService.pushNamed(Routes.csTreatments);
  }
}
