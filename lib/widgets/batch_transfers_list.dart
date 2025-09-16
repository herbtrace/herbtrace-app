import 'package:flutter/material.dart';
import '../models/batch_transfer_model.dart';
import '../models/crop_model.dart';
import '../services/batch_transfer_service.dart';
import './batch_transfer_card.dart';

class BatchTransfersList extends StatelessWidget {
  final List<BatchTransfer> transfers;
  final Map<String, CropModel> crops;

  const BatchTransfersList({
    super.key,
    required this.transfers,
    required this.crops,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transfers.length,
      itemBuilder: (context, index) {
        final transfer = transfers[index];
        final crop = crops[transfer.cropId];

        if (crop == null) {
          return const SizedBox.shrink(); // Skip if crop not found
        }

        return BatchTransferCard(batchTransfer: transfer, crop: crop);
      },
    );
  }
}
