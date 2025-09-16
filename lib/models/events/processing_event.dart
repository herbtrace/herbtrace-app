import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/collection/environmental_conditions.dart';

class ProcessingEvent {
  final String processingId;
  final int batchId;
  final String processingCompanyId;
  final LatLong companyLocation;
  final List<String> processesApplied;
  final EnvironmentalConditions processConditions;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> visualInspection;
  final bool equipmentCleaned;
  final String? notes;

  ProcessingEvent({
    required this.processingId,
    required this.batchId,
    required this.processingCompanyId,
    required this.companyLocation,
    required this.processesApplied,
    required this.processConditions,
    required this.startTime,
    required this.endTime,
    required this.visualInspection,
    required this.equipmentCleaned,
    this.notes,
  });

  factory ProcessingEvent.fromJson(Map<String, dynamic> json) {
    return ProcessingEvent(
      processingId: json['processing_id'] as String,
      batchId: json['batch_id'] as int,
      processingCompanyId: json['processing_company_id'] as String,
      companyLocation: LatLong.fromJson(json['company_location']),
      processesApplied: List<String>.from(json['processes_applied']),
      processConditions: EnvironmentalConditions.fromJson(
        json['process_conditions'],
      ),
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      visualInspection: List<String>.from(json['visual_inspection']),
      equipmentCleaned: json['equipment_cleaned'] as bool,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'processing_id': processingId,
    'batch_id': batchId,
    'processing_company_id': processingCompanyId,
    'company_location': companyLocation.toJson(),
    'processes_applied': processesApplied,
    'process_conditions': processConditions.toJson(),
    'start_time': startTime.toIso8601String(),
    'end_time': endTime.toIso8601String(),
    'visual_inspection': visualInspection,
    'equipment_cleaned': equipmentCleaned,
    'notes': notes,
  };
}
