import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/profiles/farmer/environmental_conditions.dart';
import 'package:herbtrace_app/models/profiles/farmer/farming_inputs.dart';

class CollectionEvent {
  final String id;
  final int batchId;
  final String actorId;
  final String cropId;
  final LatLong location;
  final DateTime startDate;
  final DateTime? harvestDate;
  final EnvironmentalConditions? environment;
  final FarmingInputs? inputs;
  final Map<String, dynamic>? permits;
  final String? qrCode;

  const CollectionEvent({
    required this.id,
    required this.batchId,
    required this.actorId,
    required this.cropId,
    required this.location,
    required this.startDate,
    this.harvestDate,
    this.environment,
    this.inputs,
    this.permits,
    this.qrCode,
  });

  bool get isComplete => harvestDate != null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'batchId': batchId,
    'actorId': actorId,
    'cropId': cropId,
    'location': location.toJson(),
    'startDate': startDate.toIso8601String(),
    if (harvestDate != null) 'harvestDate': harvestDate!.toIso8601String(),
    if (environment != null) 'environment': environment!.toJson(),
    if (inputs != null) 'inputs': inputs!.toJson(),
    if (permits != null) 'permits': permits,
    if (qrCode != null) 'qrCode': qrCode,
  };

  factory CollectionEvent.fromJson(Map<String, dynamic> json) =>
      CollectionEvent(
        id: json['id'] as String,
        batchId: json['batchId'] as int,
        actorId: json['actorId'] as String,
        cropId: json['cropId'] as String,
        location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
        startDate: DateTime.parse(json['startDate'] as String),
        harvestDate: json['harvestDate'] != null
            ? DateTime.parse(json['harvestDate'] as String)
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
