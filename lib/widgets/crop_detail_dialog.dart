import 'package:flutter/material.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';
import 'package:herbtrace_app/models/crop_model.dart';
import 'package:herbtrace_app/widgets/common/primary_button.dart';

class CropDetailDialog extends StatelessWidget {
  final CropModel crop;

  const CropDetailDialog({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  if (crop.imageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        crop.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 100),
                      ),
                    )
                  else
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Icon(
                        Icons.eco,
                        size: 100,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryButton(
                      padding: EdgeInsets.all(6),
                      width: double.infinity,
                      text: AppLocalizations.of(context)!.select_this_crop,
                      onPressed: () => Navigator.of(context).pop(crop),
                    ),
                    SizedBox(height: 16),

                    Text(
                      crop.getLocalizedName(context),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      crop.scientificName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoSection(
                      context,
                      'Collection Regions',
                      crop.approvedCollectionRegions
                          .map((r) => '${r.regionName}, ${r.stateName}')
                          .join('\n'),
                    ),
                    _buildInfoSection(
                      context,
                      'Quality Parameters',
                      '''Maximum Moisture: ${crop.qualityParameters.maxMoisturePercent}%
Heavy Metals Limit: ${crop.qualityParameters.heavyMetalsLimit}''',
                    ),
                    _buildInfoSection(
                      context,
                      'Processing Steps',
                      crop.requiredProcessingSteps.join(', '),
                    ),
                    _buildInfoSection(
                      context,
                      'Sustainability Notes',
                      crop.sustainabilityNotes,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
