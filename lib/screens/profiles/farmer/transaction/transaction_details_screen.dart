import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/models/common/collection_event.dart';
import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/events/processing/processing_event.dart';
import 'package:herbtrace_app/models/events/transport/transport_event.dart';
import 'package:herbtrace_app/models/quality/quality_test.dart';
import 'package:herbtrace_app/services/location/location_service.dart';
import 'package:herbtrace_app/utils/unique_id.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/models/crop_model.dart';
import 'package:herbtrace_app/providers/profiles/farmer/transaction_provider.dart';
import 'package:herbtrace_app/utils/user_preferences.dart';
import 'package:herbtrace_app/widgets/alert_dialogs.dart';

class TransactionDetailsScreen extends ConsumerWidget {
  final BatchCropModel transaction;
  final CropModel crop;

  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
    required this.crop,
  });

  Future<void> _handleEndTransaction(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showConfirmationDialog(
      context: context,
      title: 'End Transaction',
      content: 'Are you sure you want to end this transaction?',
      confirmText: 'End',
      cancelText: 'Cancel',
      isDestructive: true,
    );

    if (confirmed ?? false) {
      final profileId = await UserPreferences.getProfileId();
      final userRole = await UserPreferences.getUserRole();

      final tempQrData = {
        'from_id': profileId,
        'from_role': userRole,
        'batch_id': transaction.batchId,
        'start_time': transaction.startTime.toIso8601String(),
        'crop_id': crop.cropId,
      };

      final eventData = await _createEventBasedOnRole(userRole, tempQrData);
      final qrData = {
        'from_id': profileId,
        'from_role': userRole,
        'batch_id': transaction.batchId,
        'data': eventData,
      };

      if (context.mounted) {
        await _showQRDialog(context, qrData);
      }
    }
  }

  Future<Map<String, dynamic>> _createEventBasedOnRole(
    String role,
    Map<String, dynamic> qrData,
  ) async {
    final now = DateTime.now();
    final profileId = await UserPreferences.getProfileId();

    final LatLong loc = await LocationService().getCurrentLocation();

    switch (role.toLowerCase()) {
      case 'farmer':
        final startDate = qrData['start_time'] != null
            ? DateTime.parse(qrData['start_time'])
            : DateTime.now();

        final x = CollectionEvent(
          batchId: qrData['batch_id'].toString(),
          profileId: profileId,
          cropId: qrData['crop_id'] ?? UniqueId.generate(),
          location: LatLong(
            latitude: loc.latitude,
            longitude: loc.longitude,
            address: "Collection Site",
          ),
          startDate: startDate,
          harvestDate: startDate,
        );

        return x.toJson();

      case 'processor':
        final x = ProcessingEvent(
          processingId: UniqueId.generate(),
          batchId: qrData['batch_id'],
          processingCompanyId: profileId,
          companyLocation: loc,
          processesApplied: ['Initial Processing'],
          processConditions: null,
          startTime: now,
          endTime: now,
          visualInspection: [],
          equipmentCleaned: true,
        );
        return x.toJson();

      case 'transporter':
        final x = TransportEvent(
          transportId: UniqueId.generate(),
          batchId: qrData['batch_id'],
          provenanceFhirUrl: 'http://example.com/fhir',
          transporterId: profileId,
          origin: loc,
          destination: loc,
          startTime: now,
          endTime: now,
          transportConditions: null,
          sealed: true,
        );
        return x.toJson();

      case "laboratory":
        final x = QualityTest(
          testId: UniqueId.generate(),
          batchId: qrData['batch_id'],
          profileId: profileId,
          dateOfTest: now,
          testResults: [],
          certificationReportUrl: '',
        );
        print(x.toJson());
        return x.toJson();
      // TODO: Add other role cases as needed
      default:
        print('Unsupported role: $role');
        throw Exception('Unsupported role: $role');
    }
  }

  Future<void> _showQRDialog(
    BuildContext context,
    Map<String, dynamic> qrData,
  ) async {
    print('Showing QR Dialog with data: $qrData');
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Scan to Transfer',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Scan this QR code to transfer the batch to the next stage',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: QrImageView(
                      data: jsonEncode(qrData),
                      version: QrVersions.auto,
                      size: 234,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Batch ID: ${transaction.batchId}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop_circle_outlined),
            color: Colors.red,
            onPressed: () => _handleEndTransaction(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Crop Information',
              children: [
                _buildDetailRow('Common Name', crop.speciesName),
                _buildDetailRow('Scientific Name', crop.scientificName),
                if (crop.category != null)
                  _buildDetailRow('Category', crop.category!),
              ],
            ),

            const SizedBox(height: 24),

            _buildSection(
              title: 'Transaction Details',
              children: [
                _buildDetailRow('Batch ID', transaction.batchId),
                _buildDetailRow(
                  'Start Time',
                  _formatDateTime(transaction.startTime),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildSection(
              title: 'Quality Parameters',
              children: [
                for (var entry in crop.qualityParameters.toJson().entries)
                  _buildDetailRow(
                    _formatParameterName(entry.key),
                    entry.value.toString(),
                  ),
              ],
            ),

            const SizedBox(height: 24),

            _buildSection(
              title: 'Approved Collection Regions',
              children: [
                for (var region in crop.approvedCollectionRegions)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(region.regionName),
                    subtitle: Text(
                      '${region.stateName} (${region.latitude}, ${region.longitude})',
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 24),

            _buildSection(
              title: 'Additional Information',
              children: [
                _buildDetailRow(
                  'Allowed Harvest Months',
                  _formatMonths(crop.allowedHarvestMonths),
                ),
                if (crop.restrictedMonths.isNotEmpty)
                  _buildDetailRow(
                    'Restricted Months',
                    _formatMonths(crop.restrictedMonths),
                  ),
                _buildDetailRow(
                  'Max Wild Collection',
                  crop.maxAllowedWildCollection,
                ),
                if (crop.recommendedPractice != null)
                  _buildDetailRow(
                    'Recommended Practice',
                    crop.recommendedPractice!,
                  ),
              ],
            ),

            if (crop.sustainabilityNotes.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildSection(
                title: 'Sustainability Notes',
                children: [Text(crop.sustainabilityNotes)],
              ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryGreen,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  String _formatMonths(List<int> months) {
    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months.map((m) => monthNames[m - 1]).join(', ');
  }

  String _formatParameterName(String parameterName) {
    return parameterName
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
