class FarmingInputs {
  final String fertilizers;
  final String pesticidesUsed;
  final bool organicCertified;

  FarmingInputs({
    required this.fertilizers,
    required this.pesticidesUsed,
    required this.organicCertified,
  });

  factory FarmingInputs.fromJson(Map<String, dynamic> json) {
    return FarmingInputs(
      fertilizers: json['fertilizers'] as String,
      pesticidesUsed: json['pesticides_used'] as String,
      organicCertified: json['organic_certified'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'fertilizers': fertilizers,
    'pesticides_used': pesticidesUsed,
    'organic_certified': organicCertified,
  };
}
