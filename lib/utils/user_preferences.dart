import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _profileIdKey = 'profile_id';
  static const String _defaultProfileId = '456';

  static Future<String> getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileIdKey) ?? _defaultProfileId;
  }

  static Future<void> setProfileId(String profileId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileIdKey, profileId);
  }
}
