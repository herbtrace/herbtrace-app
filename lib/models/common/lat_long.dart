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
    'lat': latitude,
    'long': longitude,
    if (address != null) 'address': address,
  };

  factory LatLong.fromJson(Map<String, dynamic> json) => LatLong(
    latitude: json['lat'] as double? ?? json['latitude'] as double,
    longitude: json['long'] as double? ?? json['longitude'] as double,
    address: json['address'] as String?,
  );

  @override
  String toString() =>
      'LatLong(latitude: $latitude, longitude: $longitude, address: $address)';
}
