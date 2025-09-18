import 'package:herbtrace_app/models/events/collection/collection_event.dart';
import 'package:herbtrace_app/models/events/transport/transport_event.dart';
import 'package:herbtrace_app/models/events/processing/processing_event.dart';
import 'package:herbtrace_app/models/events/manufacturing/manufacturing_event.dart';
import 'package:herbtrace_app/models/events/packing/packing_event.dart';
import 'package:herbtrace_app/models/events/quality/quality_test.dart';

class QrCodeData {
  final String fromId;
  final String toId;
  final String batchId;
  final String fromRole;
  final String toRole;
  final DateTime? startTime;
  final dynamic event;

  QrCodeData({
    required this.fromId,
    required this.toId,
    required this.batchId,
    required this.fromRole,
    required this.toRole,
    this.startTime,
    required this.event,
  });

  factory QrCodeData.fromJson(Map<String, dynamic> json) {
    final eventType = json['event_type'] as String;
    dynamic eventData;

    switch (eventType) {
      case 'collection':
        eventData = CollectionEvent.fromJson(json['event']);
        break;
      case 'transport':
        eventData = TransportEvent.fromJson(json['event']);
        break;
      case 'processing':
        eventData = ProcessingEvent.fromJson(json['event']);
        break;
      case 'quality_test':
        eventData = QualityTest.fromJson(json['event']);
        break;
      case 'manufacturing':
        eventData = ManufacturingEvent.fromJson(json['event']);
        break;
      case 'packing':
        eventData = PackingEvent.fromJson(json['event']);
        break;
      default:
        throw Exception('Unknown event type: $eventType');
    }

    return QrCodeData(
      fromId: json['from_id'] as String,
      toId: json['to_id'] as String,
      batchId: json['batch_id'] as String,
      fromRole: json['from_role'] as String,
      toRole: json['to_role'] as String,
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'] as String)
          : null,
      event: eventData,
    );
  }

  Map<String, dynamic> toJson() {
    String eventType;
    if (event is CollectionEvent)
      eventType = 'collection';
    else if (event is TransportEvent)
      eventType = 'transport';
    else if (event is ProcessingEvent)
      eventType = 'processing';
    else if (event is QualityTest)
      eventType = 'quality_test';
    else if (event is ManufacturingEvent)
      eventType = 'manufacturing';
    else if (event is PackingEvent)
      eventType = 'packing';
    else
      throw Exception('Unknown event type');

    return {
      'from_id': fromId,
      'to_id': toId,
      'batch_id': batchId,
      'from_role': fromRole,
      'to_role': toRole,
      if (startTime != null) 'start_time': startTime!.toIso8601String(),
      'event_type': eventType,
      'event': event.toJson(),
    };
  }
}
