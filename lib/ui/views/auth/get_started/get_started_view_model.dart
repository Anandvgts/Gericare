import 'package:gericare_doctor/core/base/base_view_model.dart';
import 'package:gericare_doctor/locator.dart';
import 'package:gericare_doctor/router.dart';


class GetStartedViewModel extends VGTSBaseViewModel {
  void onGetStarted() {
    navigationService.pushNamed(Routes.login);
  }
}
