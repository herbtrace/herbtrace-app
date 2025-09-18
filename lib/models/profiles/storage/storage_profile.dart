import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/models/profiles/base_profile.dart';

class StorageProfile extends BaseProfile {
  final String facilityName;
  final String? certificationStatus;

  const StorageProfile({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.location,
    required this.facilityName,
    this.certificationStatus,
  }) : super(type: ProfileType.storage);

  @override
  List<String> get availableActions => [
    'Start Storage',
    'View Active Storage',
    'View History',
  ];

  @override
  String get profileTitle => 'Storage Facility Dashboard';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'location': location.toJson(),
    'type': type.toString(),
    'facilityName': facilityName,
    'certificationStatus': certificationStatus,
  };

  factory StorageProfile.fromJson(Map<String, dynamic> json) => StorageProfile(
    id: json['id'] as String,
    name: json['name'] as String,
    phoneNumber: json['phoneNumber'] as String,
    location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
    facilityName: json['facilityName'] as String,
    certificationStatus: json['certificationStatus'] as String?,
  );
}
