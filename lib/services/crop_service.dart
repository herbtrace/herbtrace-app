import 'package:herbtrace_app/data/crops.dart';
import 'package:herbtrace_app/models/crop_model.dart';

class CropService {
  // Singleton instance
  static final CropService _instance = CropService._internal();

  factory CropService() {
    return _instance;
  }

  CropService._internal();

  /// Get crop by ID
  Future<CropModel?> getCropById(String cropId) async {
    try {
      final cropData = crops.firstWhere(
        (crop) => crop['id'] == cropId,
        orElse: () => throw Exception('Crop not found'),
      );

      return CropModel.fromJson(cropData);
    } catch (e) {
      print('Error fetching crop: $e');
      return null;
    }
  }

  /// Get all crops
  Future<List<CropModel>> getAllCrops() async {
    try {
      return crops.map((crop) => CropModel.fromJson(crop)).toList();
    } catch (e) {
      print('Error fetching crops: $e');
      return [];
    }
  }
}
