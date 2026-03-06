import 'package:doctor/bootstrap.dart';
import 'package:doctor/services/session_service.dart';
import 'package:doctor/services/snackbar_service.dart';
import 'package:doctor/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/navigation_service.dart';
import 'services/preference_service.dart';
import 'services/api_base_service.dart';
import 'utils/provider_observer.dart';

final ProviderContainer providerContainer = ProviderContainer(
  observers: [MyObserver()],
);










//Global access 
final bootStrap = providerContainer.read(_bootStrapProvider);
final preferenceService = providerContainer.read(_preferenceProvider);
final navigationService = providerContainer.read(_navigationServiceProvider);
final loggerService = providerContainer.read(_loggerServiceProvider);
final snackBarService = providerContainer.read(_snackBarServiceProvider);

final apiBaseService = providerContainer.read(_apiBaseServiceProvider);
final networkService = providerContainer.read(_apiBaseServiceProvider);
final sessionService = SessionService();







//service Provider
final _snackBarServiceProvider = Provider<SnackbarService>(
  (ref) => SnackbarService(),
);
final _navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService();
});
final _preferenceProvider = Provider<PreferenceService>((ref) => PreferenceService());
final _loggerServiceProvider = Provider<LogService>((ref) => LogService());
final _bootStrapProvider =
    Provider.autoDispose<Bootstrap>((ref) => Bootstrap());



//services
final _apiBaseServiceProvider = Provider<ApiBaseService>((ref) {
  return ApiBaseService();
});


