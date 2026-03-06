// services/session_service.dart
import 'package:doctor/locator.dart';
import 'package:doctor/features/auth/models/user.dart';

class SessionService {
  bool get isLoggedIn => preferenceService.getBearerToken().isNotEmpty;

  User? get currentUser => preferenceService.getUserInfo();

  String get token => preferenceService.getBearerToken();

  Future<void> createSession({
    required String token,
    required User user,
  }) async {
    await preferenceService.setBearerToken(token);
    await preferenceService.setUserInfo(user);
  }

  Future<void> clearSession() async {
    await preferenceService.clear();
    // Clear API cache to remove old tokens
    apiBaseService.clearCache();
  }

  Future<bool> validateSession() async {
    if (!isLoggedIn) return false;

    return true;
  }
}