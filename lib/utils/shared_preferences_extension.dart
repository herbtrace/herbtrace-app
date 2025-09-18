import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExtension on SharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }
}
