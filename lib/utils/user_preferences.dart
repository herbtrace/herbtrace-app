import 'dart:convert';

import 'package:herbtrace_app/consts/sharedpreferences_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<String> getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    var x = prefs.getString(SharedPrefKeys.profileId) ?? "";
    if (x.contains(".")) return x.substring(0, x.indexOf("."));
    print(x);
    return x;
  }

  static Future<void> setProfileId(String profileId) async {
    print(profileId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKeys.profileId, profileId);
  }

  static Future<String> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.role) ?? 'farmer';
  }

  static Future<void> setUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKeys.role, role);
  }

  static Future<void> setProfileData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(data);
    await prefs.setString(SharedPrefKeys.profileData, encodedData);
  }

  static Future<Map<String, dynamic>?> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(SharedPrefKeys.profileId);
    if (encodedData == null) return null;
    return jsonDecode(encodedData) as Map<String, dynamic>;
  }

  static Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
