import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/utils/user_preferences.dart';
import 'package:herbtrace_app/providers/profiles/farmer/transaction_provider.dart';
import 'package:herbtrace_app/screens/profiles/farmer/transaction/transaction_screen.dart';
import 'package:herbtrace_app/screens/profiles/farmer/transaction/transaction_details_screen.dart';
import 'package:herbtrace_app/widgets/common/primary_button.dart';
import 'package:herbtrace_app/widgets/transaction_card.dart';

class StatusScreen extends ConsumerStatefulWidget {
  const StatusScreen({super.key});

  @override
  ConsumerState<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends ConsumerState<StatusScreen> {
  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final profileId = await UserPreferences.getProfileId();
    ref.read(transactionProvider.notifier).loadTransactions(profileId);
  }

  @override
  Widget build(BuildContext context) {
    final transactionState = ref.watch(transactionProvider);

    if (transactionState.isLoading) {
      debugPrint('Loading transactions...');
      return const Center(child: CircularProgressIndicator());
    }

    if (transactionState.error != null) {
      return Center(
        child: Text(
          transactionState.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadTransactions,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          PrimaryButton(
            text: 'Start',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionScreen(),
                ),
              );
            },
          ),
          if (transactionState.activeTransactions.isNotEmpty) ...[
            const Text(
              'Active Transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...transactionState.activeTransactions.map(
              (transaction) => TransactionCard(
                transaction: transaction,
                onTap: () {
                  final crop = ref
                      .read(transactionProvider)
                      .crops[transaction.cropId];
                  if (crop != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailsScreen(
                          transaction: transaction,
                          crop: crop,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ] else
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Text(
                  'No active transactions',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
