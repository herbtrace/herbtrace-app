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
import 'package:herbtrace_app/utils/crop_localization_utils.dart';

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
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatMonths(BuildContext context, List<int> months) {
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

  String _getLocalizedParameterName(
    BuildContext context,
    String parameterName,
  ) {
    final localizations = AppLocalizations.of(context)!;

    switch (parameterName.toLowerCase()) {
      case 'max_moisture_percent':
        return localizations.maxMoisturePercent;
      case 'root_diameter_min_mm':
        return localizations.rootDiameterMinMm;
      case 'withanolide_content_min_percent':
        return localizations.withanolideContentMinPercent;
      case 'pesticide_residue_limit':
        return localizations.pesticideResidueLimit;
      case 'heavy_metals_limit':
        return localizations.heavyMetalsLimit;
      case 'dna_authentication':
        return localizations.dnaAuthentication;
      case 'bacoside_content_min_percent':
        return localizations.bacosideContentMinPercent;
      case 'berberine_content_min_percent':
        return localizations.berberineContentMinPercent;
      case 'essential_oil_content_min_percent':
        return localizations.essentialOilContentMinPercent;
      case 'tannins_content_min_percent':
        return localizations.tanninsContentMinPercent;
      default:
        return _formatParameterName(parameterName);
    }
  }

  String _formatParameterName(String parameterName) {
    return parameterName
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget _buildDetailCard({
    required BuildContext context,
    required String title,
    required List<Widget> children,
    IconData? icon,
    Color? iconColor,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (iconColor ?? AppTheme.primaryGreen).withOpacity(
                        0.1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? AppTheme.primaryGreen,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isImportant = false,
  }) {
    if (value.isEmpty || value.toLowerCase() == 'null') {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: isImportant ? 15 : 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isImportant ? FontWeight.w700 : FontWeight.w500,
                fontSize: isImportant ? 15 : 14,
                color: isImportant ? AppTheme.primaryGreen : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionTile(dynamic region) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
          child: const Icon(
            Icons.location_on,
            color: AppTheme.primaryGreen,
            size: 20,
          ),
        ),
        title: Text(
          region.regionName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${region.stateName} (${region.latitude}, ${region.longitude})',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
      ),
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
                            Navigator.of(context).pop();

                            Navigator.of(context).pop();

                            final _ = ref.refresh(transactionProvider.future);

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
          quantity: 10.0, // TODO: Add quantity field in your transaction model
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
    final localizations = AppLocalizations.of(context)!;
    final localizedCropName = CropLocalizationUtils.getLocalizedCropName(
      context,
      crop.speciesName,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(localizations.transactionDetails),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(
              context: context,
              title: localizations.cropInformation,
              icon: Icons.eco,
              iconColor: Colors.green,
              children: [
                _buildDetailRow(
                  localizations.commonName,
                  localizedCropName,
                  isImportant: true,
                ),
                _buildDetailRow(
                  localizations.scientificName,
                  crop.scientificName,
                ),
                if (crop.category != null && crop.category!.isNotEmpty)
                  _buildDetailRow(localizations.category, crop.category!),
              ],
            ),

            _buildDetailCard(
              context: context,
              title: localizations.transactionDetails,
              icon: Icons.receipt_long,
              iconColor: Colors.blue,
              children: [
                _buildDetailRow(
                  localizations.batchId,
                  transaction.batchId,
                  isImportant: true,
                ),
                _buildDetailRow(
                  localizations.startTime,
                  _formatDateTime(transaction.startTime),
                ),
              ],
            ),

            if (crop.qualityParameters.toJson().isNotEmpty)
              _buildDetailCard(
                context: context,
                title: localizations.qualityParameters,
                icon: Icons.verified,
                iconColor: Colors.orange,
                children: [
                  for (var entry in crop.qualityParameters.toJson().entries)
                    if (entry.value != null &&
                        entry.value.toString().isNotEmpty &&
                        entry.value.toString().toLowerCase() != 'null')
                      _buildDetailRow(
                        _getLocalizedParameterName(context, entry.key),
                        entry.value.toString(),
                      ),
                ],
              ),

            if (crop.approvedCollectionRegions.isNotEmpty)
              _buildDetailCard(
                context: context,
                title: localizations.approvedCollectionRegions,
                icon: Icons.location_on,
                iconColor: Colors.red,
                children: [
                  for (var region in crop.approvedCollectionRegions)
                    _buildRegionTile(region),
                ],
              ),

            _buildDetailCard(
              context: context,
              title: localizations.additionalInformation,
              icon: Icons.info,
              iconColor: Colors.purple,
              children: [
                if (crop.allowedHarvestMonths.isNotEmpty)
                  _buildDetailRow(
                    localizations.allowedHarvestMonths,
                    _formatMonths(context, crop.allowedHarvestMonths),
                  ),
                if (crop.restrictedMonths.isNotEmpty)
                  _buildDetailRow(
                    localizations.restrictedMonths,
                    _formatMonths(context, crop.restrictedMonths),
                  ),
                if (crop.maxAllowedWildCollection.isNotEmpty)
                  _buildDetailRow(
                    localizations.maxWildCollection,
                    crop.maxAllowedWildCollection.toString(),
                  ),
                if (crop.recommendedPractice != null &&
                    crop.recommendedPractice!.isNotEmpty)
                  _buildDetailRow(
                    localizations.recommendedPractice,
                    crop.recommendedPractice!,
                  ),
              ],
            ),

            if (crop.sustainabilityNotes.isNotEmpty)
              _buildDetailCard(
                context: context,
                title: localizations.sustainabilityNotes,
                icon: Icons.nature,
                iconColor: Colors.teal,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Text(
                      crop.sustainabilityNotes,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleEndTransaction(context, ref),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.stop_circle_outlined),
        label: Text(localizations.endTransaction),
      ),
    );
  }
}
