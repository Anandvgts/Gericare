import 'dart:convert';

import 'package:doctor/core/models/user.dart';
import 'package:doctor/features/auth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenceService {
  late SharedPreferences _prefs;

  bool get hasSeenOnboarding => _prefs.getBool("has_seen_onboarding") ?? false;

Future<void> setSeenOnboarding() async => _prefs.setBool("has_seen_onboarding", true);


  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setBearerToken(String token) async {
    await _prefs.setString('ACCESS_TOKEN', token);
  }

  String getBearerToken() {
    return _prefs.getString('ACCESS_TOKEN') ?? '';
  }

  Future<void> setUserInfo(User user) async {
    await _prefs.setString('USER', jsonEncode(user.toJson()));
  }

  User? getUserInfo() {
    final data = _prefs.getString('USER');
    if (data == null) return null;
    return User.formJson(jsonDecode(data));
  }

  

  Future<void> clear() async {
    await _prefs.clear();
  }
}
