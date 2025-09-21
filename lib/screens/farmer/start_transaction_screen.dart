import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/providers/profiles/farmer/transaction_provider.dart';
import 'package:herbtrace_app/widgets/crop_dropdown.dart';

class StartTransactionScreen extends ConsumerWidget {
  const StartTransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionState = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Start Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CropDropdown(
              onCropSelected: (crop) {
                if (crop != null) {
                  ref.read(transactionProvider.notifier).startTransaction(crop);
                }
              },
            ),
            if (transactionState.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (transactionState.error != null)
              Text(
                transactionState.error!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
