import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
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
