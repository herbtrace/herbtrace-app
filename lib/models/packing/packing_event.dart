class PackingEvent {
  final String packingId;
  final String packingFhirUrl;
  final String manufacturingId;
  final String packerId;
  final DateTime dateOfPacking;
  final String qrCodeUrl;
  final String? notes;

  PackingEvent({
    required this.packingId,
    required this.packingFhirUrl,
    required this.manufacturingId,
    required this.packerId,
    required this.dateOfPacking,
    required this.qrCodeUrl,
    this.notes,
  });

  factory PackingEvent.fromJson(Map<String, dynamic> json) {
    return PackingEvent(
      packingId: json['packing_id'] as String,
      packingFhirUrl: json['packing_fhir_url'] as String,
      manufacturingId: json['manufacturing_id'] as String,
      packerId: json['packer_id'] as String,
      dateOfPacking: DateTime.parse(json['date_of_packing']),
      qrCodeUrl: json['qr_code_url'] as String,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'packing_id': packingId,
    'packing_fhir_url': packingFhirUrl,
    'manufacturing_id': manufacturingId,
    'packer_id': packerId,
    'date_of_packing': dateOfPacking.toIso8601String(),
    'qr_code_url': qrCodeUrl,
    'notes': notes,
  };
}
