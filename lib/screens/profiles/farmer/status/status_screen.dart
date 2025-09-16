import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/utils/user_preferences.dart';
import 'package:herbtrace_app/providers/profiles/farmer/transaction_provider.dart';
import 'package:herbtrace_app/screens/profiles/farmer/transaction/transaction_screen.dart';
import 'package:herbtrace_app/widgets/common/primary_button.dart';

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
              (transaction) => _TransactionCard(
                transaction: transaction,
                onEnd: () async {
                  final profileId = await UserPreferences.getProfileId();
                  ref
                      .read(transactionProvider.notifier)
                      .endTransaction(transaction.batchId, profileId);
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

class _TransactionCard extends ConsumerWidget {
  final BatchCropModel transaction;
  final VoidCallback onEnd;

  const _TransactionCard({required this.transaction, required this.onEnd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionState = ref.watch(transactionProvider);
    final crop = transactionState.crops[transaction.cropId];

    if (crop == null) {
      return const SizedBox.shrink(); // Skip if crop not found
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.grass, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        crop.speciesName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        crop.scientificName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: onEnd,
                  icon: const Icon(Icons.stop_circle_outlined),
                  label: const Text('End'),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
              ],
            ),
            const Divider(),
            _InfoRow(
              icon: Icons.tag,
              label: 'Batch ID',
              value: transaction.batchId,
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.calendar_today,
              label: 'Started',
              value: _formatDate(transaction.startTime),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.textSecondary),
        const SizedBox(width: 8),
        Text('$label:', style: const TextStyle(color: AppTheme.textSecondary)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
