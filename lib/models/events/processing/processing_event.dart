import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/collection/environmental_conditions.dart';

class ProcessingEvent {
  final String processingId;
  final String batchId;
  final String processingCompanyId;
  final LatLong companyLocation;
  final List<String> processesApplied;
  final EnvironmentalConditions? processConditions;
  final DateTime startTime;
  final DateTime endTime;
  final List<String>? visualInspection;
  final bool equipmentCleaned;
  final String? notes;

  ProcessingEvent({
    required this.processingId,
    required this.batchId,
    required this.processingCompanyId,
    required this.companyLocation,
    required this.processesApplied,
    this.processConditions,
    required this.startTime,
    required this.endTime,
    this.visualInspection,
    this.equipmentCleaned = true,
    this.notes,
  });

  factory ProcessingEvent.fromJson(Map<String, dynamic> json) {
    return ProcessingEvent(
      processingId: json['processing_id'] as String,
      batchId: json['batch_id'] as String,
      processingCompanyId: json['processing_company_id'] as String,
      companyLocation: LatLong.fromJson(json['company_location']),
      processesApplied: List<String>.from(json['processes_applied']),
      processConditions: json['process_conditions'] != null
          ? EnvironmentalConditions.fromJson(json['process_conditions'])
          : null,
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      visualInspection: json['visual_inspection'] != null
          ? List<String>.from(json['visual_inspection'])
          : null,
      equipmentCleaned: json['equipment_cleaned'] as bool? ?? true,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'processing_id': processingId,
    'batch_id': batchId,
    'processing_company_id': processingCompanyId,
    'company_location': companyLocation.toJson(),
    'processes_applied': processesApplied,
    if (processConditions != null)
      'process_conditions': processConditions!.toJson(),
    'start_time': startTime.toIso8601String(),
    'end_time': endTime.toIso8601String(),
    if (visualInspection != null) 'visual_inspection': visualInspection,
    'equipment_cleaned': equipmentCleaned,
    if (notes != null) 'notes': notes,
  };
}
