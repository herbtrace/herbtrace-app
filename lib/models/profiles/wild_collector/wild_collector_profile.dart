import 'package:herbtrace_app/models/common/lat_long.dart';
import 'package:herbtrace_app/models/common/profile_type.dart';
import 'package:herbtrace_app/models/profiles/base_profile.dart';

class WildCollectorProfile extends BaseProfile {
  final String? licenseNo;
  final String? areaAssigned;
  final List<String> certifications;
  final List<String> registeredCrops;

  const WildCollectorProfile({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.location,
    this.licenseNo,
    this.areaAssigned,
    this.certifications = const [],
    this.registeredCrops = const [],
  }) : super(type: ProfileType.wildCollector);

  @override
  List<String> get availableActions => [
    'Start Collection',
    'View Active Collections',
    'View History',
  ];

  @override
  String get profileTitle => 'Wild Collector Dashboard';

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'location': location.toJson(),
    'type': type.toString(),
    'licenseNo': licenseNo,
    'areaAssigned': areaAssigned,
    'certifications': certifications,
    'registeredCrops': registeredCrops,
  };

  factory WildCollectorProfile.fromJson(Map<String, dynamic> json) =>
      WildCollectorProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        phoneNumber: json['phoneNumber'] as String,
        location: LatLong.fromJson(json['location'] as Map<String, dynamic>),
        licenseNo: json['licenseNo'] as String?,
        areaAssigned: json['areaAssigned'] as String?,
        certifications: List<String>.from(json['certifications'] as List),
        registeredCrops: List<String>.from(json['registeredCrops'] as List),
      );
}
