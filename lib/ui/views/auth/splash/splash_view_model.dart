import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/locator.dart';
import 'package:gericare_doctor/router.dart';
import 'package:gericare_doctor/services/shared/preferences_service.dart';

class SplashViewModel extends VGTSBaseViewModel {
  @override
  Future onInit() async {
    super.onInit();

    await Future.delayed(const Duration(seconds: 2));

    final prefService = locator<PreferenceService>();
    final isLoggedIn = await prefService.isLoggedIn();

    if (isLoggedIn) {
      navigationService.replaceWith(Routes.dashboard);
    } else {
      navigationService.replaceWith(Routes.getStarted);
    }
  }
}

