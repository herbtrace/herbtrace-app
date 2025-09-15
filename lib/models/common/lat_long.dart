class LatLong {
  final double latitude;
  final double longitude;
  final String? address;

  const LatLong({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    if (address != null) 'address': address,
  };

  factory LatLong.fromJson(Map<String, dynamic> json) => LatLong(
    latitude: json['latitude'] as double,
    longitude: json['longitude'] as double,
    address: json['address'] as String?,
  );

  @override
  String toString() =>
      'LatLong(latitude: $latitude, longitude: $longitude, address: $address)';
}
