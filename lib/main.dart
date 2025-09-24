import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/consts/sharedpreferences_consts.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/providers/common/profile_provider.dart';
import 'package:herbtrace_app/screens/common/home_screen.dart';
import 'package:herbtrace_app/screens/welcome_screen.dart';
import 'package:herbtrace_app/services/language_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: HerbTraceApp(prefs: prefs),
    ),
  );
}

class HerbTraceApp extends ConsumerWidget {
  const HerbTraceApp({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileTypeProvider.notifier).state = ProfileType.fromString(
        prefs.getString(SharedPrefKeys.role) ?? '',
      );
    });

    final locale = ref.watch(languageServiceProvider);
    return MaterialApp(
      title: 'HerbTrace',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      theme: AppTheme.lightTheme,
      home: prefs.getString(SharedPrefKeys.role) == null
          ? const WelcomeScreen()
          : HomeScreen(),
    );
  }
}
