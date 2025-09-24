import 'package:flutter/material.dart';
import 'package:herbtrace_app/generated/app_localizations.dart';

class CropLocalizationUtils {
  static String getLocalizedCropName(BuildContext context, String cropName) {
    final localizations = AppLocalizations.of(context)!;

    final normalizedCropName = _normalizeCropName(cropName);

    switch (normalizedCropName.toLowerCase()) {
      case 'ashwagandha':
        return localizations.cropNameAshwagandha;
      case 'brahmi':
        return localizations.cropNameBrahmi;
      case 'giloy':
        return localizations.cropNameGiloy;
      case 'tulsi':
        return localizations.cropNameTulsi;
      case 'arjuna':
        return localizations.cropNameArjuna;
      default:
        return cropName;
    }
  }

  static Map<String, String> getAllLocalizedCropNames(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return {
      'Ashwagandha': localizations.cropNameAshwagandha,
      'Brahmi': localizations.cropNameBrahmi,
      'Giloy': localizations.cropNameGiloy,
      'Tulsi': localizations.cropNameTulsi,
      'Arjuna': localizations.cropNameArjuna,
    };
  }

  static List<String> getSupportedCropNames() {
    return ['Ashwagandha', 'Brahmi', 'Giloy', 'Tulsi', 'Arjuna'];
  }

  static bool isLocalizable(String cropName) {
    final normalizedName = _normalizeCropName(cropName);
    return getSupportedCropNames()
        .map((name) => name.toLowerCase())
        .contains(normalizedName.toLowerCase());
  }

  static String _normalizeCropName(String cropName) {
    return cropName
        .trim()
        .toLowerCase()
        .split(' ')
        .map((word) {
          return word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : word;
        })
        .join(' ');
  }

  static String getEnglishCropName(BuildContext context, String localizedName) {
    final localizations = AppLocalizations.of(context)!;

    if (localizedName == localizations.cropNameAshwagandha) {
      return 'Ashwagandha';
    } else if (localizedName == localizations.cropNameBrahmi) {
      return 'Brahmi';
    } else if (localizedName == localizations.cropNameGiloy) {
      return 'Giloy';
    } else if (localizedName == localizations.cropNameTulsi) {
      return 'Tulsi';
    } else if (localizedName == localizations.cropNameArjuna) {
      return 'Arjuna';
    }

    return localizedName;
  }
}
