import 'package:doctor/features/auth/data/auth_repository.dart';
import 'package:doctor/locator.dart';
import 'package:doctor/router.dart';
import 'package:doctor/services/snackbar_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_controller.g.dart';

@riverpod
class LogoutController extends _$LogoutController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider.notifier).logout();

      await sessionService.clearSession();
      snackBarService.showSnackbar(
        message: "Logged out successfully",
        snakBarType: SnackbarType.success,
      );
      await Future.delayed(const Duration(milliseconds: 300));
      navigationService.popAllAndPushNamed(Routes.login);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}
