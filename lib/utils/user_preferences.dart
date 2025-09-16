import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _profileIdKey = 'profile_id';
  static const String _userRoleKey = 'user_role';
  static const String _defaultProfileId = '456';
  static const String _defaultUserRole = 'farmer';

  static Future<String> getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileIdKey) ?? _defaultProfileId;
  }

  static Future<void> setProfileId(String profileId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileIdKey, profileId);
  }

  static Future<String> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey) ?? _defaultUserRole;
  }

  static Future<void> setUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userRoleKey, role);
  }
}
