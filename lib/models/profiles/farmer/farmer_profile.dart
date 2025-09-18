import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/models/profiles/base_profile.dart';

class FarmerProfile extends BaseProfile {
  final String aadharNumber;
  final String? landRecords;
  final List<String> certifications;
  final List<String> registeredCrops;

  const FarmerProfile({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.location,
    required this.aadharNumber,
    this.landRecords,
    this.certifications = const [],
    this.registeredCrops = const [],
  }) : super(type: ProfileType.farmer);

  @override
  List<String> get availableActions => [
    'Start Transaction',
    'View Active Transactions',
    'View History',
  ];

  @override
  String get profileTitle => 'Farmer Dashboard';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'location': location.toJson(),
    'type': type.toString(),
    'aadharNumber': aadharNumber,
    'landRecords': landRecords,
    'certifications': certifications,
    'registeredCrops': registeredCrops,
  };

  factory FarmerProfile.fromJson(Map<String, dynamic> json) => FarmerProfile(
    id: json['id'] as String,
    name: json['name'] as String,
    phoneNumber: json['phoneNumber'] as String,
    location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
    aadharNumber: json['aadharNumber'] as String,
    landRecords: json['landRecords'] as String?,
    certifications: List<String>.from(json['certifications'] as List),
    registeredCrops: List<String>.from(json['registeredCrops'] as List),
  );
}
