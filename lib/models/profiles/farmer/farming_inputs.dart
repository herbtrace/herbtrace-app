class FarmingInputs {
  final String? fertilizers;
  final String? pesticidesUsed;
  final bool organicCertified;

  const FarmingInputs({
    this.fertilizers,
    this.pesticidesUsed,
    this.organicCertified = false,
  });

  Map<String, dynamic> toJson() => {
    if (fertilizers != null) 'fertilizers': fertilizers,
    if (pesticidesUsed != null) 'pesticidesUsed': pesticidesUsed,
    'organicCertified': organicCertified,
  };

  factory FarmingInputs.fromJson(Map<String, dynamic> json) => FarmingInputs(
    fertilizers: json['fertilizers'] as String?,
    pesticidesUsed: json['pesticidesUsed'] as String?,
    organicCertified: json['organicCertified'] as bool? ?? false,
  );
}
