class PackingEvent {
  final String packingId;
  final String packingFhirUrl;
  final String manufacturingId;
  final String profileId;
  final DateTime dateOfPacking;
  final String? qrCodeUrl;
  final String? notes;

  PackingEvent({
    required this.packingId,
    required this.packingFhirUrl,
    required this.manufacturingId,
    required this.profileId,
    required this.dateOfPacking,
    this.qrCodeUrl,
    this.notes,
  });

  factory PackingEvent.fromJson(Map<String, dynamic> json) {
    return PackingEvent(
      packingId: json['packing_id'] as String,
      packingFhirUrl: json['packing_fhir_url'] as String,
      manufacturingId: json['manufacturing_id'] as String,
      profileId: json['profile_id'] as String,
      dateOfPacking: DateTime.parse(json['date_of_packing']),
      qrCodeUrl: json['qr_code_url'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'packing_id': packingId,
    'packing_fhir_url': packingFhirUrl,
    'manufacturing_id': manufacturingId,
    'profile_id': profileId,
    'date_of_packing': dateOfPacking.toIso8601String(),
    if (qrCodeUrl != null) 'qr_code_url': qrCodeUrl,
    if (notes != null) 'notes': notes,
  };
}
