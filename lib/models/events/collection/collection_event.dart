import 'package:herbtrace_app/models/collection/environmental_conditions.dart';
import 'package:herbtrace_app/models/collection/permit_compliance.dart';
import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/profiles/farmer/farming_inputs.dart';

class CollectionEvent {
  final String batchId;
  final String profileId;
  final String cropId;
  final LatLong location;
  final DateTime startDate;
  final DateTime harvestDate;
  final EnvironmentalConditions? environment;
  final FarmingInputs? inputs;
  final List<PermitCompliance>? permits;

  CollectionEvent({
    required this.batchId,
    required this.profileId,
    required this.cropId,
    required this.location,
    required this.startDate,
    required this.harvestDate,
    this.environment,
    this.inputs,
    this.permits,
  });

  factory CollectionEvent.fromJson(Map<String, dynamic> json) {
    return CollectionEvent(
      batchId: json['batch_id'] as String,
      profileId: json['profile_id'] as String,
      cropId: json['crop_id'] as String,
      location: LatLong.fromJson(json['location']),
      startDate: DateTime.parse(json['start_date']),
      harvestDate: DateTime.parse(json['harvest_date']),
      environment: json['environment'] != null
          ? EnvironmentalConditions.fromJson(json['environment'])
          : null,
      inputs: json['inputs'] != null
          ? FarmingInputs.fromJson(json['inputs'])
          : null,
      permits: json['permits'] != null
          ? (json['permits'] as List)
                .map(
                  (e) => PermitCompliance.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'batch_id': batchId,
    'profile_id': profileId,
    'crop_id': cropId,
    'location': location.toJson(),
    'start_date': startDate.toIso8601String(),
    'harvest_date': harvestDate.toIso8601String(),
    'environment': environment?.toJson(),
    'inputs': inputs?.toJson(),
    'permits': permits?.map((e) => e.toJson()).toList(),
  };
}
