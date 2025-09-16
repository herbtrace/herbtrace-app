class PermitCompliance {
  final Map<String, String> certificates;
  PermitCompliance({required this.certificates});

  factory PermitCompliance.fromJson(Map<String, dynamic> json) {
    return PermitCompliance(
      certificates: Map<String, String>.from(json['certificates']),
    );
  }

  Map<String, dynamic> toJson() => {'certificates': certificates};
}
