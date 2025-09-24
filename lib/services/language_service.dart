import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:herbtrace_app/consts/sharedpreferences_consts.dart';

class LanguageService extends StateNotifier<Locale> {
  final SharedPreferences _prefs;

  static const String _localeKey = SharedPrefKeys.localeKey;

  LanguageService(this._prefs)
    : super(Locale(_prefs.getString(_localeKey) ?? 'en'));

  Future<void> changeLanguage(String languageCode) async {
    await _prefs.setString(_localeKey, languageCode);
    state = Locale(languageCode);
  }

  String getCurrentLanguage() {
    return state.languageCode;
  }

  static final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'nameInEnglish': "English"},
    {'code': 'hi', 'name': 'हिंदी', 'nameInEnglish': "Hindi"},
    {'code': 'kn', 'name': 'ಕನ್ನಡ', 'nameInEnglish': "Kannada"},
  ];
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final languageServiceProvider = StateNotifierProvider<LanguageService, Locale>((
  ref,
) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LanguageService(prefs);
});
