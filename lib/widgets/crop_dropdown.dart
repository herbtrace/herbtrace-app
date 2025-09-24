import 'package:flutter/material.dart';
import 'package:herbtrace_app/data/crops.dart';
import 'package:herbtrace_app/models/crop_model.dart';
import 'package:herbtrace_app/widgets/crop_detail_dialog.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';

class CropDropdown extends StatefulWidget {
  final void Function(CropModel?) onCropSelected;

  const CropDropdown({super.key, required this.onCropSelected});

  @override
  State<CropDropdown> createState() => _CropDropdownState();
}

class _CropDropdownState extends State<CropDropdown> {
  final List<CropModel> _crops = crops
      .map((cropData) => CropModel.fromJson(cropData))
      .toList();
  CropModel? _selectedCrop;

  Future<void> _showCropDetails(BuildContext context, CropModel crop) async {
    final selectedCrop = await showDialog<CropModel>(
      context: context,
      builder: (context) => CropDetailDialog(crop: crop),
    );

    if (selectedCrop != null) {
      setState(() => _selectedCrop = selectedCrop);
      widget.onCropSelected(selectedCrop);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppLocalizations.of(context)!.select_a_crop),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _crops.length,
            itemBuilder: (context, index) {
              final crop = _crops[index];
              final isSelected = crop == _selectedCrop;

              return ListTile(
                leading: crop.imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          crop.imageUrl,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.eco),
                        ),
                      )
                    : const Icon(Icons.eco),
                title: Text(crop.getLocalizedName(context)),
                subtitle: Text(
                  crop.scientificName,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                selected: isSelected,
                onTap: () => _showCropDetails(context, crop),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.info_outline),
              );
            },
          ),
        ),
      ],
    );
  }
}
