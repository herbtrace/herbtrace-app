import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/config/constants/app_constants.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/consts/sharedpreferences_consts.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
import 'package:herbtrace_app/providers/common/profile_provider.dart';
import 'package:herbtrace_app/screens/common/home_screen.dart';
import 'package:herbtrace_app/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const HerbTraceApp(),
    ),
  );
}

class HerbTraceApp extends ConsumerWidget {
  const HerbTraceApp({super.key});

  void initProfile(WidgetRef ref) async {
    if (ref.read(profileTypeProvider) == null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.getString(SharedPrefKeys.profileType);
      ref.read(profileTypeProvider.notifier).setProfileType(ProfileType.farmer);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageServiceProvider);
    return MaterialApp(
      title: 'HerbTrace',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}

extension on StateController<ProfileType?> {
  void setProfileType(ProfileType farmer) {}
}
