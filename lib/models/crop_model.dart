class CropModel {
  final String cropId;
  final String specimenFhirUrl;
  final String imageUrl;
  final String speciesName;
  final List<String> localNames;
  final String scientificName;
  final String? category;
  final List<int> allowedHarvestMonths;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CropModel && other.cropId == cropId;
  }

  @override
  int get hashCode => cropId.hashCode;
  final List<int> restrictedMonths;
  final List<ApprovedCollectionRegion> approvedCollectionRegions;
  final String maxAllowedWildCollection;
  final String? recommendedPractice;
  final RecommendedQualityParameters qualityParameters;
  final List<String> requiredProcessingSteps;
  final String sustainabilityNotes;

  CropModel({
    required this.cropId,
    required this.specimenFhirUrl,
    required this.imageUrl,
    required this.speciesName,
    required this.localNames,
    required this.scientificName,
    this.category,
    required this.allowedHarvestMonths,
    required this.restrictedMonths,
    required this.approvedCollectionRegions,
    required this.maxAllowedWildCollection,
    this.recommendedPractice,
    required this.qualityParameters,
    required this.requiredProcessingSteps,
    required this.sustainabilityNotes,
  });

  factory CropModel.fromJson(Map<String, dynamic> json) {
    return CropModel(
      cropId: json['id'] as String,
      specimenFhirUrl: json['specimen_fhir_url'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      speciesName: json['species_common_name'] as String,
      localNames: [json['species_common_name'] as String],
      scientificName: json['species_scientific_name'] as String,
      category: json['category'] as String?,
      allowedHarvestMonths: List<int>.from(
        json['allowed_harvest_months'] as List,
      ),
      restrictedMonths: List<int>.from(json['restricted_months'] as List),
      approvedCollectionRegions: (json['approved_collection_regions'] as List)
          .map((region) => ApprovedCollectionRegion.fromJson(region))
          .toList(),
      maxAllowedWildCollection: json['max_allowed_wild_collection'] as String,
      recommendedPractice: json['recommended_practice'] as String?,
      qualityParameters: RecommendedQualityParameters.fromJson(
        json['quality_parameters'],
      ),
      requiredProcessingSteps: List<String>.from(
        json['processing_steps'] as List,
      ),
      sustainabilityNotes: json['sustainability_notes'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': cropId,
      'specimen_fhir_url': specimenFhirUrl,
      'image_url': imageUrl,
      'species_common_name': speciesName,
      'local_names': localNames,
      'species_scientific_name': scientificName,
      'category': category,
      'allowed_harvest_months': allowedHarvestMonths,
      'restricted_months': restrictedMonths,
      'approved_collection_regions': approvedCollectionRegions
          .map((region) => region.toJson())
          .toList(),
      'max_allowed_wild_collection': maxAllowedWildCollection,
      'recommended_practice': recommendedPractice,
      'quality_parameters': qualityParameters.toJson(),
      'processing_steps': requiredProcessingSteps,
      'sustainability_notes': sustainabilityNotes,
    };
  }
}

class ApprovedCollectionRegion {
  final String regionName;
  final String stateName;
  final List<int> allowedMonths;
  final double latitude;
  final double longitude;

  ApprovedCollectionRegion({
    required this.regionName,
    required this.stateName,
    required this.allowedMonths,
    required this.latitude,
    required this.longitude,
  });

  factory ApprovedCollectionRegion.fromJson(Map<String, dynamic> json) {
    return ApprovedCollectionRegion(
      regionName: json['region_name'] as String,
      stateName: json['state_name'] as String,
      allowedMonths: [],
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'region_name': regionName,
      'state_name': stateName,
      'allowed_months': allowedMonths,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class RecommendedQualityParameters {
  final double maxMoisturePercent;
  final double? rootDiameterMinMm;
  final double? withanolideContentMinPercent;
  final String? pesticideResidueLimit;
  final String heavyMetalsLimit;
  final String? dnaAuthentication;

  RecommendedQualityParameters({
    required this.maxMoisturePercent,
    this.rootDiameterMinMm,
    this.withanolideContentMinPercent,
    this.pesticideResidueLimit,
    required this.heavyMetalsLimit,
    this.dnaAuthentication,
  });

  factory RecommendedQualityParameters.fromJson(Map<String, dynamic> json) {
    return RecommendedQualityParameters(
      maxMoisturePercent: (json['max_moisture_percent'] as num).toDouble(),
      rootDiameterMinMm: json['root_diameter_min_mm'] != null
          ? (json['root_diameter_min_mm'] as num).toDouble()
          : null,
      withanolideContentMinPercent:
          json['withanolide_content_min_percent'] != null
          ? (json['withanolide_content_min_percent'] as num).toDouble()
          : null,
      pesticideResidueLimit: json['pesticide_residue_limit'] as String?,
      heavyMetalsLimit: json['heavy_metals_limit'] as String,
      dnaAuthentication: json['dna_authentication'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max_moisture_percent': maxMoisturePercent,
      'root_diameter_min_mm': rootDiameterMinMm,
      'withanolide_content_min_percent': withanolideContentMinPercent,
      'pesticide_residue_limit': pesticideResidueLimit,
      'heavy_metals_limit': heavyMetalsLimit,
      'dna_authentication': dnaAuthentication,
    };
  }
}
