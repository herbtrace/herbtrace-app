import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/models/common/collection_event.dart';
import 'package:herbtrace_app/providers/profiles/farmer/transaction_provider.dart';

class StatusScreen extends ConsumerWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (transactionState.activeTransactions.isNotEmpty) ...[
          const Text(
            'Active Transactions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...transactionState.activeTransactions
              .map(
                (transaction) => _TransactionCard(
                  transaction: transaction,
                  onEnd: () {
                    ref
                        .read(transactionProvider.notifier)
                        .endTransaction(transaction.id);
                  },
                ),
              )
              .toList(),
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
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final CollectionEvent transaction;
  final VoidCallback onEnd;

  const _TransactionCard({required this.transaction, required this.onEnd});

  @override
  Widget build(BuildContext context) {
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
                Text(
                  transaction.cropId,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (transaction.qrCode != null)
                  IconButton(
                    icon: const Icon(Icons.qr_code),
                    onPressed: () => _showQRDialog(context),
                  )
                else
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
              icon: Icons.calendar_today,
              label: 'Started',
              value: _formatDate(transaction.startDate),
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.location_on,
              label: 'Location',
              value:
                  '${transaction.location.latitude}, ${transaction.location.longitude}',
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  void _showQRDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transaction QR Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO(chetanr25): Uncomment when qr_flutter is added
            // QrImage(
            //   data: transaction.qrCode!,
            //   version: QrVersions.auto,
            //   size: 200.0,
            // ),
            const SizedBox(height: 16),
            Text(
              'Crop: ${transaction.cropId}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
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
