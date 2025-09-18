import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/collection/environmental_conditions.dart';

class TransportEvent {
  final String transportId;
  final String batchId;
  final String provenanceFhirUrl;
  final String transporterId;
  final LatLong origin;
  final LatLong destination;
  final DateTime startTime;
  final DateTime endTime;
  final EnvironmentalConditions? transportConditions;
  final bool sealed;
  final String? notes;

  TransportEvent({
    required this.transportId,
    required this.batchId,
    required this.provenanceFhirUrl,
    required this.transporterId,
    required this.origin,
    required this.destination,
    required this.startTime,
    required this.endTime,
    this.transportConditions,
    this.sealed = true,
    this.notes,
  });

  factory TransportEvent.fromJson(Map<String, dynamic> json) {
    return TransportEvent(
      transportId: json['transport_id'] as String,
      batchId: json['batch_id'] as String,
      provenanceFhirUrl: json['provenance_fhir_url'] as String,
      transporterId: json['transporter_id'] as String,
      origin: LatLong.fromJson(json['origin']),
      destination: LatLong.fromJson(json['destination']),
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      transportConditions: json['transport_conditions'] != null
          ? EnvironmentalConditions.fromJson(json['transport_conditions'])
          : null,
      sealed: json['sealed'] as bool? ?? true,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'transport_id': transportId,
    'batch_id': batchId,
    'provenance_fhir_url': provenanceFhirUrl,
    'transporter_id': transporterId,
    'origin': origin.toJson(),
    'destination': destination.toJson(),
    'start_time': startTime.toIso8601String(),
    'end_time': endTime.toIso8601String(),

    'transport_conditions': transportConditions?.toJson(),
    'sealed': sealed,
    'notes': notes,
  };
}
