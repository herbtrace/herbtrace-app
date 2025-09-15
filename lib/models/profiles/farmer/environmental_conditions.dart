import 'package:herbtrace_app/models/common/lat_long.dart';

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
    if (soilQuality != null) 'soilQuality': soilQuality,
    if (moisture != null) 'moisture': moisture,
    if (temperature != null) 'temperature': temperature,
    if (humidity != null) 'humidity': humidity,
    if (weatherConditions != null) 'weatherConditions': weatherConditions,
    if (irrigationMethod != null) 'irrigationMethod': irrigationMethod,
  };

  factory EnvironmentalConditions.fromJson(Map<String, dynamic> json) =>
      EnvironmentalConditions(
        soilQuality: json['soilQuality'] as String?,
        moisture: json['moisture'] as double?,
        temperature: json['temperature'] as double?,
        humidity: json['humidity'] as double?,
        weatherConditions: json['weatherConditions'] as String?,
        irrigationMethod: json['irrigationMethod'] as String?,
      );
}
