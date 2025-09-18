class EnvironmentalConditions {
  final String? soilQuality;
  final double? moisture;
  final double? temperature;
  final double? humidity;
  final String? weatherConditions;
  final String? irrigationMethod;

  EnvironmentalConditions({
    this.soilQuality,
    this.moisture,
    this.temperature,
    this.humidity,
    this.weatherConditions,
    this.irrigationMethod,
  });

  factory EnvironmentalConditions.fromJson(Map<String, dynamic> json) {
    return EnvironmentalConditions(
      soilQuality: json['soil_quality'] as String?,
      moisture: json['moisture']?.toDouble(),
      temperature: json['temperature']?.toDouble(),
      humidity: json['humidity']?.toDouble(),
      weatherConditions: json['weather_conditions'] as String?,
      irrigationMethod: json['irrigation_method'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    if (soilQuality != null) 'soil_quality': soilQuality,
    'moisture': moisture,
    'temperature': temperature,
    'humidity': humidity,
    'weather_conditions': weatherConditions,
    'irrigation_method': irrigationMethod,
  };
}
