import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const _tokenKey = 'auth_token';

  /// SAVE TOKEN
  Future<void> saveBearerToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// GET TOKEN
  Future<String?> getBearerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// CHECK LOGIN
  Future<bool> isLoggedIn() async {
    final token = await getBearerToken();
    return token != null && token.isNotEmpty;
  }

  /// CLEAR SESSION
  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }



  Future<void> saveUser(Map<String, dynamic> user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', jsonEncode(user));
}

Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user');

    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// 🔹 GET STAFF ID
  Future<int> getStaffId() async {
    final user = await getUser();
    if (user == null) return 0;
    return user['id'] ?? 0;
  }




}
