import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/crop_model.dart';
import 'environmental_conditions.dart';
import 'farming_inputs.dart';
import 'permit_compliance.dart';

class CollectionEvent {
  final int batchId;
  final String actorId;
  final CropModel crop;
  final LatLong location;
  final DateTime startDate;
  final DateTime harvestDate;
  final EnvironmentalConditions? environment;
  final FarmingInputs? inputs;
  final PermitCompliance? permits;

  CollectionEvent({
    required this.batchId,
    required this.actorId,
    required this.crop,
    required this.location,
    required this.startDate,
    required this.harvestDate,
    required this.environment,
    this.inputs,
    required this.permits,
  });

  factory CollectionEvent.fromJson(Map<String, dynamic> json) {
    return CollectionEvent(
      batchId: json['batch_id'] as int,
      actorId: json['actor_id'] as String,
      crop: CropModel.fromJson(json['crop']),
      location: LatLong.fromJson(json['location']),
      startDate: DateTime.parse(json['start_date']),
      harvestDate: DateTime.parse(json['harvest_date']),
      environment: EnvironmentalConditions.fromJson(json['environment']),
      inputs: json['inputs'] != null
          ? FarmingInputs.fromJson(json['inputs'])
          : null,
      permits: PermitCompliance.fromJson(json['permits']),
    );
  }

  Map<String, dynamic> toJson() => {
    'batch_id': batchId,
    'actor_id': actorId,
    'crop': crop.toJson(),
    'location': location.toJson(),
    'start_date': startDate.toIso8601String(),
    'harvest_date': harvestDate.toIso8601String(),
    'environment': environment?.toJson(),
    'inputs': inputs?.toJson(),
    'permits': permits?.toJson(),
  };
}
