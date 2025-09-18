class EnvironmentalConditions {
  final String? soilQuality;
  final double? moisture;
  final double? temperature;
  final double? humidity;
  final String? weatherConditions;
  final String? irrigationMethod;

  const EnvironmentalConditions({
    this.soilQuality,
    this.moisture,
    this.temperature,
    this.humidity,
    this.weatherConditions,
    this.irrigationMethod,
  });

  Map<String, dynamic> toJson() => {
    if (soilQuality != null) 'soil_quality': soilQuality,
    if (moisture != null) 'moisture': moisture,
    if (temperature != null) 'temperature': temperature,
    if (humidity != null) 'humidity': humidity,
    if (weatherConditions != null) 'weather_conditions': weatherConditions,
    if (irrigationMethod != null) 'irrigation_method': irrigationMethod,
  };

  factory EnvironmentalConditions.fromJson(Map<String, dynamic> json) =>
      EnvironmentalConditions(
        soilQuality: json['soil_quality'] as String?,
        moisture: json['moisture'] as double?,
        temperature: json['temperature'] as double?,
        humidity: json['humidity'] as double?,
        weatherConditions: json['weather_conditions'] as String?,
        irrigationMethod: json['irrigation_method'] as String?,
      );
}
