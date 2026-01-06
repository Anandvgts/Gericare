import 'package:gericare_doctor/services/api/staff_consultation_service.dart';
import 'package:get_it/get_it.dart';

import 'package:gericare_doctor/services/shared/dialog_service.dart';
import 'package:gericare_doctor/services/shared/navigation_service.dart';
import 'package:gericare_doctor/services/shared/preferences_service.dart';

import 'package:gericare_doctor/services/api/api_service.dart';
import 'package:gericare_doctor/services/api/auth_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  /// ---------------- CORE SERVICES ----------------

  locator.registerLazySingleton<NavigationService>(
    () => NavigationService(),
  );

  locator.registerLazySingleton<DialogService>(
    () => DialogService(),
  );

  locator.registerLazySingleton<PreferenceService>(
    () => PreferenceService(),
  );

  /// ---------------- API SERVICES ----------------

  locator.registerLazySingleton<ApiService>(
    () => ApiService(),
  );

  locator.registerLazySingleton<AuthService>(
    () => AuthService(locator<ApiService>()),
  );


  locator.registerLazySingleton<StaffConsultationService>(
  () => StaffConsultationService(locator<ApiService>()),
);

}

/// ----------- GLOBAL SHORTCUTS (OPTIONAL) -----------

final NavigationService navigationService = locator<NavigationService>();

final DialogService dialogService = locator<DialogService>();

final PreferenceService preferenceService = locator<PreferenceService>();
