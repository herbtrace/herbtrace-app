import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
import 'package:herbtrace_app/services/language_service.dart';
import 'package:herbtrace_app/widgets/language_switch_button.dart';

class FirstScreen extends ConsumerWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.watch(languageServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('HerbTrace'),
        actions: [LanguageSwitchButton()],
      ),
      body: Center(
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.welcome,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
