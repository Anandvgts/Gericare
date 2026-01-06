import 'package:fluttertoast/fluttertoast.dart';
import 'package:gericare_doctor/locator.dart';
import 'package:gericare_doctor/router.dart';
import 'package:gericare_doctor/services/shared/preferences_service.dart';

/// Helper class for logout functionality
class LogoutHelper {
  static final PreferenceService _pref = locator<PreferenceService>();

  /// Perform logout - Clear session and navigate to login
  static Future<void> logout({
    String message = "Logged out successfully",
    bool showToast = true,
  }) async {
    try {
      // Clear all saved data
      await _pref.clearData();

      // Show toast if needed
      if (showToast) {
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
        );
      }

      // Navigate to login and clear navigation stack
      navigationService.popAllAndPushNamed(Routes.login);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error during logout",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  /// Session expired logout (called from ApiService)
  static Future<void> sessionExpired() async {
    await logout(
      message: "Session expired. Please login again",
      showToast: true,
    );
  }
}

// Example usage in any ViewModel:
// 
// // Simple logout button
// void onLogoutPressed() async {
//   await LogoutHelper.logout();
// }
//
// // Logout with confirmation dialog
// void onLogoutPressed() async {
//   final confirm = await _dialogService.showConfirmDialog(
//     title: "Logout",
//     description: "Are you sure you want to logout?",
//   );
//   
//   if (confirm == true) {
//     await LogoutHelper.logout();
//   }
// }