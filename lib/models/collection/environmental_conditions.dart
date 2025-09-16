class EnvironmentalConditions {
  final String soilQuality;
  final double moisture;
  final double temperature;
  final double humidity;
  final String weatherConditions;
  final String irrigationMethod;

  EnvironmentalConditions({
    required this.soilQuality,
    required this.moisture,
    required this.temperature,
    required this.humidity,
    required this.weatherConditions,
    required this.irrigationMethod,
  });

  factory EnvironmentalConditions.fromJson(Map<String, dynamic> json) {
    return EnvironmentalConditions(
      soilQuality: json['soil_quality'] as String,
      moisture: json['moisture'] as double,
      temperature: json['temperature'] as double,
      humidity: json['humidity'] as double,
      weatherConditions: json['weather_conditions'] as String,
      irrigationMethod: json['irrigation_method'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'soil_quality': soilQuality,
    'moisture': moisture,
    'temperature': temperature,
    'humidity': humidity,
    'weather_conditions': weatherConditions,
    'irrigation_method': irrigationMethod,
  };
}
