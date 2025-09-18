class PermitCompliance {
  final String permitId;
  final String permitType;
  final String issuer;
  final DateTime? validUntil;

  PermitCompliance({
    required this.permitId,
    required this.permitType,
    required this.issuer,
    this.validUntil,
  });

  factory PermitCompliance.fromJson(Map<String, dynamic> json) {
    return PermitCompliance(
      permitId: json['permit_id'] as String,
      permitType: json['permit_type'] as String,
      issuer: json['issuer'] as String,
      validUntil: json['valid_until'] != null
          ? DateTime.parse(json['valid_until'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'permit_id': permitId,
    'permit_type': permitType,
    'issuer': issuer,
    if (validUntil != null) 'valid_until': validUntil!.toIso8601String(),
  };
}
