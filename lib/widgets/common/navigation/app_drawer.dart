import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
import 'package:herbtrace_app/providers/common/profile_provider.dart';
import 'package:herbtrace_app/screens/welcome_screen.dart';
import 'package:herbtrace_app/services/language_service.dart';
import 'package:herbtrace_app/widgets/alert_dialogs/language_selection_dialog.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(currentProfileProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.primaryGreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  profile?.name ?? 'Guest User',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  profile?.phoneNumber ?? '',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(AppLocalizations.of(context)!.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(AppLocalizations.of(context)!.transaction_history),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to transaction history
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to settings
            },
          ),

          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.change_language),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => const LanguageSelectionDialog(),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppLocalizations.of(context)!.logout),
            onTap: () async {
              Navigator.pop(context);
              final prefs = ref.read(sharedPreferencesProvider);
              prefs.clear();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
