import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/profiles/farmer/environmental_conditions.dart';
import 'package:herbtrace_app/models/profiles/farmer/farming_inputs.dart';

class CollectionEvent {
  final String batchId;
  final String profileId;
  final String cropId;
  final LatLong location;
  final DateTime startDate;
  final DateTime? harvestDate;
  final EnvironmentalConditions? environment;
  final FarmingInputs? inputs;
  final Map<String, dynamic>? permits;
  final String? qrCode;

  const CollectionEvent({
    required this.batchId,
    required this.profileId,
    required this.cropId,
    required this.location,
    required this.startDate,
    required this.harvestDate,
    this.environment,
    this.inputs,
    this.permits,
    this.qrCode,
  });

  bool get isComplete => harvestDate != null;

  Map<String, dynamic> toJson() => {
    'batch_id': batchId,
    'profile_id': profileId,
    'crop_id': cropId,
    'location': location.toJson(),
    'start_date': startDate.toIso8601String(),
    'harvest_date': harvestDate?.toIso8601String(),
    'environment': environment?.toJson(),
    'inputs': inputs?.toJson(),
    'permits': permits,
  };

  factory CollectionEvent.fromJson(Map<String, dynamic> json) =>
      CollectionEvent(
        batchId: json['batch_id'] as String,
        profileId: json['profile_id'] as String,
        cropId: json['crop_id'] as String,
        location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
        startDate: DateTime.parse(json['start_date'] as String),
        harvestDate: json['harvest_date'] != null
            ? DateTime.parse(json['harvest_date'] as String)
            : null,
        environment: json['environment'] != null
            ? EnvironmentalConditions.fromJson(
                json['environment'] as Map<String, dynamic>,
              )
            : null,
        inputs: json['inputs'] != null
            ? FarmingInputs.fromJson(json['inputs'] as Map<String, dynamic>)
            : null,
        permits: json['permits'] as Map<String, dynamic>?,
        qrCode: json['qrCode'] as String?,
      );
}
