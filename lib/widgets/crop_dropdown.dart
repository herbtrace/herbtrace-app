import 'package:flutter/material.dart';
import 'package:herbtrace_app/data/crops.dart';
import 'package:herbtrace_app/models/crop_model.dart';

class CropDropdown extends StatelessWidget {
  final void Function(CropModel?) onCropSelected;

  const CropDropdown({super.key, required this.onCropSelected});

  List<CropModel> _loadCrops() {
    return crops.map((cropData) => CropModel.fromJson(cropData)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cropsList = _loadCrops();

    return DropdownButtonFormField<CropModel>(
      decoration: const InputDecoration(
        labelText: 'Select Crop',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.grass),
      ),
      value: null,
      isExpanded: true,
      menuMaxHeight: 300,
      items: cropsList.map((crop) {
        return DropdownMenuItem<CropModel>(
          value: crop,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: double.infinity),
            child: ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: -2),
              contentPadding: EdgeInsets.zero,
              title: Text(crop.speciesName, overflow: TextOverflow.ellipsis),
              subtitle: Text(
                crop.scientificName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: onCropSelected,
    );
  }
}
