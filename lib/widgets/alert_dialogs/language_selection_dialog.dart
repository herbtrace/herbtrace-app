import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
import 'package:herbtrace_app/services/language_service.dart';

class LanguageSelectionDialog extends ConsumerWidget {
  const LanguageSelectionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(languageServiceProvider);

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.select_language),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: LanguageService.languages.map((language) {
          return ListTile(
            leading: Radio<String>(
              value: language['code']!,
              groupValue: currentLocale.languageCode,
              onChanged: (String? value) {
                if (value != null) {
                  ref
                      .read(languageServiceProvider.notifier)
                      .changeLanguage(value);
                  Navigator.pop(context);
                }
              },
            ),
            title: Text(language['name']!),
            onTap: () {
              ref
                  .read(languageServiceProvider.notifier)
                  .changeLanguage(language['code']!);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
