import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
import 'package:herbtrace_app/models/common/collection_event.dart';
import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/events/processing/processing_event.dart';
import 'package:herbtrace_app/models/events/transport/transport_event.dart';
import 'package:herbtrace_app/models/quality/quality_test.dart';
import 'package:herbtrace_app/providers/profiles/farmer/transaction_provider.dart';
import 'package:herbtrace_app/services/location/location_service.dart';
import 'package:herbtrace_app/utils/unique_id.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:herbtrace_app/config/theme.dart';
import 'package:herbtrace_app/models/crop_model.dart';
import 'package:herbtrace_app/utils/user_preferences.dart';
import 'package:herbtrace_app/widgets/alert_dialogs/transaction_end_dialog.dart';

final transactionProvider = FutureProvider<List<BatchCropModel>>((ref) async {
  // TODO: Implement transaction fetching logic
  return [];
});

class TransactionDetailsScreen extends ConsumerWidget {
  final BatchCropModel transaction;
  final CropModel crop;

  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
    required this.crop,
  });

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

  Future<Map<String, dynamic>?> _createEventBasedOnRole(
    String role,
    Map<String, dynamic> qrData,
  ) async {
    final now = DateTime.now();
    final profileId = await UserPreferences.getProfileId();

    LatLong loc;
    try {
      loc = await LocationService().getCurrentLocation();
    } catch (e) {
      throw Exception(
        'Failed to get current location. Please check your location permissions and try again.',
      );
    }

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
        return x.toJson();

      default:
        throw Exception('Unsupported role: $role');
    }
  }

  Future<void> _showQRDialog(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> qrData,
  ) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              color: AppTheme.primaryGreen,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.supply_chain_transfer,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.transfer_instructions,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            // Close the QR dialog
                            Navigator.of(context).pop();

                            // Go back to home page
                            Navigator.of(context).pop();

                            // Refresh the list
                            await ref.refresh(transactionProvider.future);

                            // Show success message
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Transfer completed successfully',
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(Icons.check_circle_outline, size: 16),
                          ),
                          label: Text(
                            AppLocalizations.of(context)!.transfer_confirmation,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.primaryGreen.withOpacity(0.2),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 250,
                              height: 250,
                              padding: const EdgeInsets.all(8),
                              child: QrImageView(
                                data: jsonEncode(qrData),
                                version: QrVersions.auto,
                                size: 234,
                                backgroundColor: Colors.white,
                                eyeStyle: const QrEyeStyle(
                                  eyeShape: QrEyeShape.square,
                                  color: AppTheme.primaryGreen,
                                ),
                                dataModuleStyle: const QrDataModuleStyle(
                                  dataModuleShape: QrDataModuleShape.square,
                                  color: AppTheme.primaryGreen,
                                ),
                              ),
                            ),
                            Text(
                              '${AppLocalizations.of(context)!.batch_id_label}: ${transaction.batchId}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.scan_qr_instructions,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleEndTransaction(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final currentTime = DateTime.now();

    try {
      final confirmed = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (context) => TransactionEndDialog(
          startTime: transaction.startTime,
          endTime: currentTime,
          cropName: crop.speciesName,
          quantity: 0.0, // TODO: Add quantity field in your transaction model
          onConfirm: () async {
            try {
              final profileId = await UserPreferences.getProfileId();
              final userRole = await UserPreferences.getUserRole();

              final tempQrData = {
                'from_id': profileId,
                'from_role': userRole,
                'batch_id': transaction.batchId,
                'start_time': transaction.startTime.toIso8601String(),
                'crop_id': crop.cropId,
              };

              final eventData = await _createEventBasedOnRole(
                userRole,
                tempQrData,
              );
              return {
                'from_id': profileId,
                'from_role': userRole,
                'batch_id': transaction.batchId,
                'data': eventData,
              };
            } catch (e) {
              throw Exception('Failed to process transaction: ${e.toString()}');
            }
          },
          onCancel: () => Navigator.of(context).pop(null),
        ),
      );

      if (confirmed != null && context.mounted) {
        await _showQRDialog(context, ref, confirmed);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Details'), elevation: 0),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                      crop.maxAllowedWildCollection.toString(),
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
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleEndTransaction(context, ref),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.stop_circle_outlined),
        label: const Text('End Transaction'),
      ),
    );
  }
}
