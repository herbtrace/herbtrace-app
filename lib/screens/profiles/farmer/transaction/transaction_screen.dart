import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herbtrace_app/data/crops.dart';
import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/crop_model.dart';
import 'package:herbtrace_app/models/profiles/farmer/farmer_profile.dart';
import 'package:herbtrace_app/widgets/crop_dropdown.dart';
import 'package:herbtrace_app/providers/common/profile_provider.dart';
import 'package:herbtrace_app/providers/profiles/farmer/transaction_provider.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  String? _selectedCrop;
  bool _isValidatingLocation = false;

  @override
  Widget build(BuildContext context) {
    var profile = ref.watch(currentProfileProvider);
    final transactionState = ref.watch(transactionProvider);

    profile ??= FarmerProfile(
      id: 'temp_id',
      name: 'Temp User',
      phoneNumber: '0000000000',
      registeredCrops: ['Sample Crop 1', 'Sample Crop 2'],
      certifications: ['Sample Certification'],
      location: LatLong(latitude: 10, longitude: 10),
      aadharNumber: '',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('New Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Start New Transaction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CropDropdown(
                      onCropSelected: (crop) {
                        if (crop != null) {
                          setState(() => _selectedCrop = crop.cropId);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    if (_selectedCrop != null) ...[
                      ElevatedButton.icon(
                        onPressed: _isValidatingLocation
                            ? null
                            : () => _validateAndStartTransaction(),
                        icon: _isValidatingLocation
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.add_location),
                        label: Text(
                          _isValidatingLocation
                              ? 'Validating Location...'
                              : 'Start',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (transactionState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  transactionState.error!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _validateAndStartTransaction() async {
    if (_selectedCrop == null) return;

    setState(() => _isValidatingLocation = true);

    try {
      final cropsList = crops
          .map((cropData) => CropModel.fromJson(cropData))
          .toList();
      final selectedCrop = cropsList.firstWhere(
        (c) => c.cropId == _selectedCrop,
      );

      await ref
          .read(transactionProvider.notifier)
          .startTransaction(selectedCrop);

      if (mounted) {}
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isValidatingLocation = false);
      }
    }
  }
}
